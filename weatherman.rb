require 'csv'
require 'date'

if __FILE__ == $PROGRAM_NAME
  if ARGV[0] == '-e'
    year = ARGV[1]
    path = ARGV[2].dup

    max_temp = -1
    min_temp = 1000
    max_humid = -1
    max_temp_day = '', min_temp_day = '', max_humid_day = ''

    path << "*#{year}*"

    # Iterate over all files of given year
    Dir.glob(path) do |file|
      CSV.foreach(file, headers: true, skip_blanks: true, skip_lines: '<!--') do |row|
        if max_temp < row['Max TemperatureC'].to_i
          max_temp = row['Max TemperatureC'].to_i
          max_temp_day = row['PKT'] || row['PKST'] || row['GST']
        end
        if min_temp > row['Min TemperatureC'].to_i
          min_temp = row['Min TemperatureC'].to_i
          min_temp_day = row['PKT'] || row['PKST'] || row['GST']
        end
        if max_humid < row['Max Humidity'].to_i
          max_humid = row['Max Humidity'].to_i
          max_humid_day = row['PKT'] || row['PKST'] || row['GST']
        end
      end
    end

    puts "Highest: #{max_temp}C on #{Date.parse(max_temp_day).strftime('%B %d')}"
    puts "Lowest: #{min_temp}C on #{Date.parse(min_temp_day).strftime('%B %d')}"
    puts "Humid: #{max_humid}% on #{Date.parse(max_humid_day).strftime('%B %d')}"

  elsif ARGV[0] == '-a'
    month = ARGV[1][%r{/[0-9]+}][1..-1].to_i
    month_name = Date::ABBR_MONTHNAMES[month]
    path = ARGV[2].dup

    avg_max_temp = 0
    avg_min_temp = 0
    avg_humid = 0
    all_months_count = 0

    path << "*#{month_name}*"

    # Iterate over all files of given month for all years
    Dir.glob(path) do |file|
      CSV.foreach(file, headers: true, skip_blanks: true, skip_lines: '<!--') do |unedited_row|
        row = {}
        # Remove whitespace to get the correct headers
        unedited_row.each { |key, value| row[key.strip] = value }

        avg_max_temp += row['Max TemperatureC'].to_i
        avg_min_temp += row['Min TemperatureC'].to_i
        avg_humid += row['Mean Humidity'].to_i
        all_months_count += 1
      end
    end
    # To calculate average values
    avg_max_temp /= all_months_count
    avg_min_temp /= all_months_count
    avg_humid /= all_months_count

    puts "Highest Average: #{avg_max_temp}C"
    puts "Lowest Average: #{avg_min_temp}C"
    puts "Average Humidity: #{avg_humid}%"
  end
end
