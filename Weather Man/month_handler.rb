require 'csv'

def month_handler(path)
  avg_max_temp = 0
  avg_min_temp = 0
  avg_humid = 0
  days_count = 0

  # Iterate over each row (day) of the given file
  CSV.foreach(path, headers: true, skip_blanks: true, skip_lines: '<!--') do |unedited_row|
    row = {}
    # Remove whitespace to get the correct headers
    unedited_row.each { |key, value| row[key.strip] = value }

    avg_max_temp += row['Max TemperatureC'].to_i
    avg_min_temp += row['Min TemperatureC'].to_i
    avg_humid += row['Mean Humidity'].to_i
    days_count += 1
  end

  # Calculate average values
  avg_max_temp /= days_count
  avg_min_temp /= days_count
  avg_humid /= days_count

  puts "Highest Average: #{avg_max_temp}C"
  puts "Lowest Average: #{avg_min_temp}C"
  puts "Average Humidity: #{avg_humid}%"
end
