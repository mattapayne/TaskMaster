module TaskMaster
  class CalendarTrigger < Trigger
    
    class ScheduleFactory
      
      def self.get(type)
        if type.nil? || !schedule_types.keys.include?(type.to_sym)
          raise "Invalid schedule type: #{type}. Must be one of #{schedule_types.keys.to_sentence}"
        end
        return schedule_types[type.to_sym].new
      end
      
      def self.schedule_types
        {:weekly => ScheduleByWeek, :daily => ScheduleByDay, 
          :monthly => ScheduleByMonth, :monthdayofweek => ScheduleByMonthDayOfWeek}
      end
      
    end
    
    class ScheduleByDay
      
      def interval(interval)
        if CalendarHelper::DAYS_IN_YEAR.include?(interval.to_i)
          @days_interval = interval
        else
          raise "Invalid day interval: #{interval}. Must be in the range of #{CalendarHelper::DAYS_IN_YEAR}"
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
        if CalendarHelper::WEEKS_IN_YEAR.include?(interval.to_i)
           @weeks_interval = interval
         else
           raise "Invalid week interval: #{interval}. Must be in the range of #{CalendarHelper::WEEKS_IN_YEAR}"
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
      
      def days_of_month(*day_numbers)
        day_numbers.each do |day|
          unless CalendarHelper::DAYS_IN_MONTH.include?(day.to_i)
            raise "Invalid day number: #{day}. It must be in the range of #{CalendarHelper::DAYS_IN_MONTH}"
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
          unless CalendarHelper::WEEKS_IN_YEAR.include?(week.to_i)
            raise "Invalid week number. Must be in the range of #{CalendarHelper::WEEKS_IN_YEAR}"
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