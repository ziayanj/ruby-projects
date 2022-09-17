require 'nokogiri'

# Function to generate XML according to the standard sitemap protocol
def generate_xml(visited_links)
  protocol = 'http://www.sitemaps.org/schemas/sitemap/0.9'

  Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
    xml.urlset(xmlns: protocol) do
      # Iterate over all the links
      visited_links.each do |link|
        # Set a new <url> tag for each link
        xml.url do
          # The url tag has a loc child
          xml.loc link
        end
      end
    end
  end
end
