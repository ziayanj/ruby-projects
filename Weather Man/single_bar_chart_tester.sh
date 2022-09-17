MONTHS=(ZERO Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)

# Using only 2006 for testing. Can be replaced to test for any other year.
# Note that not all years have files for all the months available.

# Test all Murree months
for i in $(seq 1 12)
 do ruby weatherman.rb -cc 2006/$i ./Murree_weather/Murree_weather_2006_${MONTHS[i]}.txt
done

# Test all Lahore months
for i in $(seq 1 12)
 do ruby weatherman.rb -cc 2006/$i ./lahore_weather/lahore_weather_2006_${MONTHS[i]}.txt
done

# Test all Dubai months
for i in $(seq 1 12)
 do ruby weatherman.rb -cc 2006/$i ./Dubai_weather/Dubai_weather_2006_${MONTHS[i]}.txt
done