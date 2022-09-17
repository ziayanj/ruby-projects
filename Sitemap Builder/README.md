# sitemap-builder

Given a URL, prints out the sitemap for it in XML, following the [standard sitemap protocol](https://www.sitemaps.org/index.html).

Uses a BFS approach to find out the links inside a given link, and then recursively goes to each to find the links inside that link. This is done until no new links are left.

Finally, a formatted output in XML is printed.
## Usage: 
  > ruby sitemap_builder.rb -url {URL}

## Testing:
  Following links can be used for testing:

    https://raw.githubusercontent.com/gophercises/link/solution/ex1.html

    https://raw.githubusercontent.com/gophercises/link/solution/ex2.html

    https://raw.githubusercontent.com/gophercises/link/solution/ex3.html

    https://raw.githubusercontent.com/gophercises/link/solution/ex4.html
