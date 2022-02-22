# Test all Murree months
for i in $(seq 1 12)
 do ruby weatherman.rb -a 2005/$i ./Murree_weather/
done

# Test all Lahore months
for i in $(seq 1 12)
 do ruby weatherman.rb -a 2005/$i ./lahore_weather/
done

# Test all Dubai months
for i in $(seq 1 12)
 do ruby weatherman.rb -a 2005/$i ./Dubai_weather/
done