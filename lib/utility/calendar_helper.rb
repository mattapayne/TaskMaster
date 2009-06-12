module TaskMaster
  module CalendarHelper
    
    MAX_DAYS_IN_YEAR = 365
    MIN_DAYS_IN_YEAR = 1
    
    MAX_WEEKS_IN_YEAR = 52
    MIN_WEEKS_IN_YEAR = 1
    
    MAX_DAYS_IN_MONTH = 32
    MIN_DAYS_IN_MONTH = 1
    
    MAX_ALLOWABLE_DAYS_IN_MONTH = 32
        
    DAY_MAP = {
      "Monday" => lambda {|b| b.Monday},
      "Tuesday" => lambda {|b| b.Tuesday},
      "Wednesday" => lambda {|b| b.Wednesday},
      "Thursday" => lambda {|b| b.Thursday},
      "Friday" => lambda {|b| b.Friday},
      "Saturday" => lambda {|b| b.Saturday},
      "Sunday" => lambda {|b| b.Sunday}
    }.freeze
    
    MONTH_MAP = {
      "January" => lambda {|b| b.January},
      "February" => lambda {|b| b.February},
      "March" => lambda {|b| b.March},
      "April" => lambda {|b| b.April},
      "May" => lambda {|b| b.May},
      "June" => lambda {|b| b.June},
      "July" => lambda {|b| b.July},
      "August" => lambda {|b| b.August},
      "September" => lambda {|b| b.September},
      "October" => lambda {|b| b.October},
      "November" => lambda {|b| b.November},
      "December" => lambda {|b| b.December}
    }.freeze
    
    MONTHS = MONTH_MAP.keys
    DAYS_OF_WEEK = DAY_MAP.keys
        
    def set_day(builder, day)
      if DAY_MAP.key?(day.to_s.downcase.capitalize)
        DAY_MAP[day.to_s.downcase.capitalize].call(builder)
      end
    end
    
    def set_month(builder, month)
      if MONTH_MAP.key?(month.to_s.downcase.capitalize)
        MONTH_MAP[month.to_s.downcase.capitalize].call(builder)
      end
    end
  end
end