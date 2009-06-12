module TaskMaster
  class CalendarTrigger < Trigger
    
    class ScheduleFactory
      
      SCHEDULE_TYPES = [:weekly, :daily, :monthly, :monthdayofweek].freeze
      
      def self.get(type)
        if type.nil? || !SCHEDULE_TYPES.include?(type.to_sym)
          raise "Invalid schedule type: #{type}. Must be one of #{SCHEDULE_TYPES.to_sentence}"
        end
        schedule = nil
        case type
          when :daily
            schedule = ScheduleByDay.new
          when :weekly
            schedule = ScheduleByWeek.new
          when :monthly
            schedule = ScheduleByMonth.new
          when :monthdayofweek
            schedule = ScheduleByMonthDayOfWeek.new
        end
        schedule
      end
      
    end
    
    class ScheduleByDay
      
      def interval(interval)
        if interval.to_i <= CalendarHelper::MAX_DAYS_IN_YEAR && 
          interval.to_i >= CalendarHelper::MIN_DAYS_IN_YEAR
          @days_interval = interval
        else
          raise "Invalid day interval: #{interval}. Must be between #{CalendarHelper::MIN_DAYS_IN_YEAR} and #{CalendarHelper::MAX_DAYS_PER_YEAR}"
        end
      end
      
      def to_xml(builder)
        builder.ScheduleByDay do
          builder.DaysInterval @days_interval if @days_interval
        end
      end
      
      def valid?
        true
      end
      
    end
    
    class ScheduleByWeek
      include CalendarHelper, CalendarHelper::Days
      
      def initialize
        @days = []
      end
      
      def interval(interval)
        if interval.to_i <= CalendarHelper::MAX_WEEKS_IN_YEAR && 
          interval.to_i >= CalendarHelper::MIN_WEEKS_IN_YEAR
           @weeks_interval = interval
         else
           raise "Invalid week interval: #{interval}. Must be between #{CalendarHelper::MIN_WEEKS_IN_YEAR} and #{CalendarHelper::MAX_WEEKS_IN_YEAR}"
         end
      end
      
      def to_xml(builder)
        builder.ScheduleByWeek do
          builder.WeeksInterval @weeks_interval if @weeks_interval
          unless @days.empty?
            builder.DaysOfWeek do
              @days.each do |day|
                set_day(builder, day)
              end
            end
          end
        end
      end
      
      def valid?
        true
      end
      
    end
    
    class ScheduleByMonth
      include CalendarHelper, CalendarHelper::Months
      
      def initialize
        @months = []
        @days = []
      end
      
      def days_in_month(*day_numbers)
        day_numbers.each do |day|
          unless day.to_i >= CalendarHelper::MIN_DAYS_IN_MONTH && 
            day.to_i <= CalendarHelper::MAX_DAYS_IN_MONTH
            raise "Invalid day number: #{day}. It must be between #{CalendarHelper::MIN_DAYS_IN_MONTH} and #{CalendarHelper::MAX_DAYS_IN_MONTH}"
          end
          if @days.size < CalendarHelper::MAX_ALLOWABLE_DAYS_IN_MONTH
            @days << day.to_i
          else
            raise "You may only specify #{CalendarHelper::MAX_ALLOWABLE_DAYS_IN_MONTH} days"
          end
        end
      end
      
      def to_xml(builder)
        builder.ScheduleByMonth do
          unless @days.empty?
            builder.DaysOfMonth do
              @days.each {|d| builder.Day d }
            end
          end
          unless @months.empty?
            builder.Months do
              @months.each do |m|
                set_month(builder, m)
              end
            end
          end
        end
      end
      
      def valid?
        true
      end
      
    end
    
    class ScheduleByMonthDayOfWeek
      include CalendarHelper, CalendarHelper::Months, CalendarHelper::Days
      
      def initialize
        @months = []
        @weeks = []
        @days = []
      end
      
      def weeks(*week_numbers)
        week_numbers.each do |week|
          unless week.to_i >= CalendarHelper::MIN_WEEKS_IN_YEAR && 
            week.to_i <= CalendarHelper::MAX_WEEKS_IN_YEAR
            raise "Invalid week number. Must be between #{CalendarHelper::MIN_WEEKS_IN_YEAR} and #{CalendarHelper::MAX_WEEKS_IN_YEAR}"
          end
          @weeks << week.to_i
        end
      end
      
      def valid?
        true
      end
      
      def to_xml(builder)
        builder.ScheduleByMonthDayOfWeek do
          unless @weeks.empty?
            builder.Weeks do
              @weeks.each {|w| builder.Week w}
            end
          end
          unless @days.empty?
            builder.DaysOfWeek do
              @days.each do |day|
                set_day(builder, day)
              end
            end
          end
          unless @months.empty?
            builder.Months do
              @months.each do |m|
                set_month(builder, m)
              end
            end
          end
        end
      end
    end
    
    def random_delay(duration)
      @random_delay = Duration.new(duration)
    end
    
    def daily_schedule(&block)
      schedule(:daily, &block)
    end
    
    def weekly_schedule(&block)
      schedule(:weekly, &block)
    end
    
    def monthly_schedule(&block)
      schedule(:monthly, &block)
    end
    
    def month_day_of_week_schedule(&block)
      schedule(:monthdayofweek, &block)
    end
    
    def schedule(type = :daily, &block)
      if block_given?
        @schedule = ScheduleFactory.get(type)
        @schedule.instance_eval(&block)
        unless @schedule.valid?
          raise "Invalid schedule."
        end
      else
        raise "You must supply a block to configure the Calendar Trigger schedule."
      end
    end
    
    def valid?
      (@start_boundary && !@start_boundary.blank?) && (@schedule && !@schedule.blank?)
    end
    
    def to_xml(builder)
      builder.CalendarTrigger do
        super(builder)
        builder.RandomDelay @random_delay.to_s if @random_delay
        if @schedule
          @schedule.to_xml(builder)
        end
      end
    end
  end
end