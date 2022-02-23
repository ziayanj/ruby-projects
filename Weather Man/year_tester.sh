# Test all Murree years
for i in $(seq 2004 2016)
 do ruby weatherman.rb -e $i ./Murree_weather/
done

# Test all Lahore years
for i in $(seq 1996 2011)
 do ruby weatherman.rb -e $i ./lahore_weather/
done

# Test all Dubai years
for i in $(seq 2004 2016)
 do ruby weatherman.rb -e $i ./Dubai_weather/
done