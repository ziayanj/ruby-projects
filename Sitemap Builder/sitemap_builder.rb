require_relative 'links_handler'
require_relative 'xml_generator'

if __FILE__ == $PROGRAM_NAME
  if !ARGV[0] || !ARGV[1]
    abort("Usage: ruby #{$PROGRAM_NAME} -url {URL}")
  end

  url = ARGV[1].dup
  begin
    # Will only work with .com, .io, .net, edu, .org domains.
    domain = url.match(/.*(\..+\.)(com|io|net|org|edu).*/).captures[0]
  rescue NoMethodError
    abort('Invalid URL')
  end

  # Get all links from the HTML of the root.
  all_links = get_links(url)
  # Filter out links of the required domain.
  all_filtered_links = filter_links(all_links, domain)
  visited_links = [url]

  all_filtered_links.each do |link|
    # Ensure the current link has not already been visited
    if !visited_links.include?(link)
      # Get all links of the current link
      current_links = get_links(link)
      # Filter out links of the required domain
      current_filtered_links = filter_links(current_links, domain)
      # Append to the being looped over array, after removing duplicates
      # This works like a BFS appraoch, as new child links get added next
      # to all links of the current depth
      all_filtered_links.concat(current_filtered_links).uniq
      visited_links << link
    end
  end

  # Generate the XML of all visited links, according to the sitemap protocol
  xml_builder = generate_xml(visited_links)
  puts xml_builder.to_xml
end
