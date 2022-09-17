require 'csv'
require 'date'
require_relative 'colors'

def bar_chart_handler(path, lines)
  # Get month and year for printing out
  year = ARGV[1].split('/')[0]
  month = ARGV[1].split('/')[1]

  # Convert month number into it's name
  month_name = Date::MONTHNAMES[month.to_i]
  puts "#{month_name} #{year}"

  # Iterate over each row (day) of the given file
  CSV.foreach(path, headers: true, skip_blanks: true, skip_lines: '<!--') do |row|
    max_temp = row['Max TemperatureC'].to_i
    min_temp = row['Min TemperatureC'].to_i
    day = row['PKT'] || row['PKST'] || row['GST']
    date = Date.parse(day).strftime('%d')

    # Because there's no way to output negative counts
    min_temp = 0 if min_temp.negative?

    # Print the output with two horizontal bars
    if lines == 'double'
      puts "#{date} " << ('+' * max_temp).red << " #{max_temp}C"
      puts "#{date} " << ('+' * min_temp).blue << " #{min_temp}C"

    # Print the output with a single horizontal bar
    else
      puts "#{date} " << ('+' * max_temp).red << ('+' * min_temp).blue << " #{max_temp}C - #{min_temp}C"
    end
  end
end
