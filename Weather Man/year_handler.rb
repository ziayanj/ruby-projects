require 'csv'
require 'date'

def year_handler(year, path)
  max_temp = max_humid = -1
  min_temp = 1000
  max_temp_day = '', min_temp_day = '', max_humid_day = ''

  path << "*#{year}*"

  # Iterate over all files of a given year
  Dir.glob(path) do |file|
    # Iterate over each row (day) inside the file
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

  # Print the output by converting date into the required format
  puts "Highest: #{max_temp}C on #{Date.parse(max_temp_day).strftime('%B %d')}"
  puts "Lowest: #{min_temp}C on #{Date.parse(min_temp_day).strftime('%B %d')}"
  puts "Humid: #{max_humid}% on #{Date.parse(max_humid_day).strftime('%B %d')}"
end