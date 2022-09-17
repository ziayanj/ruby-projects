require 'open-uri'
require 'net/http'
require 'nokogiri'

# Function to get all links in the HTML of a given URL.
def get_links(url)
  # To check if the link is valid
  response = Net::HTTP.get_response(URI.parse(url))
  if response.code.to_i >= 400
    return []
  end

  opened_url = URI.open(url)
  doc = Nokogiri::HTML(opened_url)

  # Iterate over each 'a' tag from the HTML.
  hrefs = doc.css('a').map do |link|
    # If the 'a' tag has a non-empty 'href' attribute
    if (href = link.attr('href')) && !href.empty?
      unless href == "#" # Because this links back to itself.
        # For relative links, this will append the link to the root url.
        URI::join(url, href)
      end
    end
  end
  # To remove nil and duplicate values
  hrefs = hrefs.compact.uniq
  # This is a 'hack' used to clean up the links array
  hrefs.join("\n").split("\n")
end

# Function to get links of the required domain only
def filter_links(links, domain)
  links.select { |link| link.include?(domain) }
end
