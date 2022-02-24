require_relative 'year_handler'
require_relative 'month_handler'
require_relative 'bar_chart_handler'

if __FILE__ == $PROGRAM_NAME
  # Check if the program has been called correctly
  if !ARGV[1] || !ARGV[2]
    abort("Usage: ruby #{$PROGRAM_NAME} {flag} {year[/month]} {path}")
  end

  path = ARGV[2].dup

  case ARGV[0]
  when '-e'
    year = ARGV[1]
    year_handler(year, path)
  when '-a'
    month_handler(path)
  when '-c'
    bar_chart_handler(path, 'double')
  when '-cc'
    bar_chart_handler(path, 'single')
  else
    puts 'Please use one of the following flags: -e, -a, -c, -cc'
  end
end
