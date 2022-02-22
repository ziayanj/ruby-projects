require 'csv'
require 'date'

# Adding colors to the String class to use for logging into console
class String
  def red
    "\e[32m#{self}\e[0m"
  end

  def blue
    "\e[34m#{self}\e[0m"
  end
end

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
    # Used for an earlier (wrong) implementation that took data from all years for the given month.
    # month = ARGV[1][%r{/[0-9]+}][1..-1].to_i
    # month_name = Date::ABBR_MONTHNAMES[month]
    # path << "*#{month_name}*"

    path = ARGV[2].dup

    avg_max_temp = 0
    avg_min_temp = 0
    avg_humid = 0
    days_count = 0

    CSV.foreach(path, headers: true, skip_blanks: true, skip_lines: '<!--') do |unedited_row|
      row = {}
      # Remove whitespace to get the correct headers
      unedited_row.each { |key, value| row[key.strip] = value }

      avg_max_temp += row['Max TemperatureC'].to_i
      avg_min_temp += row['Min TemperatureC'].to_i
      avg_humid += row['Mean Humidity'].to_i
      days_count += 1
    end

    # To calculate average values
    avg_max_temp /= days_count
    avg_min_temp /= days_count
    avg_humid /= days_count

    puts "Highest Average: #{avg_max_temp}C"
    puts "Lowest Average: #{avg_min_temp}C"
    puts "Average Humidity: #{avg_humid}%"

  elsif ARGV[0] == '-c'
    path = ARGV[2].dup

    max_temp = -1
    min_temp = 1000

    CSV.foreach(path, headers: true, skip_blanks: true, skip_lines: '<!--') do |row|
      max_temp = row['Max TemperatureC'].to_i
      min_temp = row['Min TemperatureC'].to_i
      day = row['PKT'] || row['PKST'] || row['GST']
      date = Date.parse(day).strftime('%d')

      # Because there's no way to output negative counts.
      min_temp = 0 if min_temp < 0

      puts "#{date} " << ('+' * max_temp).red << " #{max_temp}C"
      puts "#{date} " << ('+' * min_temp).blue << " #{min_temp}C"
    end
  end
end
