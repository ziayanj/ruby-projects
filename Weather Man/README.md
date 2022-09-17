# weather-man

## Usage: 

* For Years:

  > ruby weatherman.rb -e $YEAR /path/to/filesFolder
  

* For Months:

  >  ruby weatherman.rb -a $YEAR/$MONTH /path/to/files

  
*  For Bar Charts:

    * Double Line:
    >>  ruby weatherman.rb -c $YEAR/$MONTH /path/to/files

    * Single Line:
    >>  ruby weatherman.rb -cc $YEAR/$MONTH /path/to/files

Works with any of the following flags: -e, -a, -c, -cc

## Testing:

  * Execute ./year_tester.sh to test for all years of all three cities.

  *  Execute ./month_tester.sh to test for all months of all three cities for a given year (default: 2006).

  *  Execute ./bar_charts_tester.sh to test for double horizontal bars of all months of all three cities for a given year (default: 2006).

  *  Execute ./single_bar_chart_tester.sh to test for single horizontal bar of all months of all three cities for a given year (default: 2006).
