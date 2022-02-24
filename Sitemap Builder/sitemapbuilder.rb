require 'open-uri'
require 'net/http'
require 'nokogiri'

def get_links(url)
  # To check if the link is valid
  response = Net::HTTP.get_response(URI.parse(url))
  if response.code.to_i >= 400
    return []
  end

  opened_url = URI.open(url)
  doc = Nokogiri::HTML(opened_url)
  hrefs = doc.css('a').map do |link|
    if (href = link.attr('href')) && !href.empty?
      URI::join(url, href)
    end
  end
  hrefs = hrefs.compact.uniq
  hrefs.join("\n").split("\n")
end

def filter_links(links, domain)
  links.select { |link| link.include?(domain) }
end

if __FILE__ == $PROGRAM_NAME
  if !ARGV[0] || !ARGV[1]
    puts "Usage: ruby #{$PROGRAM_NAME} -url {URL}"
  end

  url = ARGV[1].dup
  # source = open(url).read
  domain = url.match(/.*(\..+\.)com.*/).captures[0]

  all_links = get_links(url)
  # p all_links
  all_filtered_links = filter_links(all_links, domain)
  # p all_filtered_links
  visited_links = [url]
  # p visited_links

  all_filtered_links.each do |link|
    if !visited_links.include?(link)
      current_links = get_links(link)
      # p current_links
      current_filtered_links = filter_links(current_links, domain)
      all_filtered_links.concat(current_filtered_links).uniq
      # p all_filtered_links
      visited_links << link
      # p visited_links
    end
  end
  p visited_links

  xml_builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
    xml.urlset(xmlns: url) {
      visited_links.each do |link|
        xml.url {
          xml.loc link
        }
      end
    }
  end
  puts xml_builder.to_xml
end
