module TaskMaster
  
  class Duration
    
    class Entry
      attr_accessor :value, :symbol
      
      def initialize(symbol, value)
        @value, @symbol = value, symbol
      end
    end
    
    def initialize(seconds)
      unless seconds.is_a?(Fixnum) || seconds.is_a?(Float)
        raise ArgumentError.new("Duration expects either a Fixnum or a Float")
      end
      @seconds = seconds
    end
    
    def to_s
      convert_to_formatted_datetime_string
    end
    
    def valid?
      @seconds.to_i >= 60.seconds
    end
    
    private
    
    def calculate_datetime_values
      @date_values = []
      @time_values = []
      years = @seconds.to_i / 1.year.to_i
      remaining_seconds = @seconds.to_i - years.years.to_i
      months = remaining_seconds.to_i / 1.month.to_i
      remaining_seconds = remaining_seconds.to_i - months.months.to_i
      days = remaining_seconds.to_i / 1.day.to_i
      remaining_seconds = remaining_seconds.to_i - days.day.to_i
      hours = remaining_seconds.to_i / 1.hour.to_i
      remaining_seconds = remaining_seconds.to_i - hours.hours.to_i
      minutes = remaining_seconds.to_i / 1.minute.to_i
      remaining_seconds = remaining_seconds.to_i - minutes.minutes.to_i
      @date_values << Entry.new("Y", years.to_i) if years.to_i > 0
      @date_values << Entry.new("M", months.to_i) if months.to_i > 0
      @date_values << Entry.new("D", days.to_i) if days.to_i > 0
      @time_values << Entry.new("H", hours.to_i) if hours.to_i > 0
      @time_values << Entry.new("M", minutes.to_i) if minutes.to_i > 0
      @time_values << Entry.new("S", remaining_seconds.to_i) if remaining_seconds.to_i > 0
    end
    
    def convert_to_formatted_datetime_string
      calculate_datetime_values
      date_string = @date_values.inject(String.new) do |s, e|
        unless e.value.blank?
          s << "#{e.value}#{e.symbol}"
          s
        end
      end
      time_string = @time_values.inject(String.new) do |s, e|
        unless e.value.blank?
          s << "#{e.value}#{e.symbol}"
          s
        end
      end
      "P#{date_string}T#{time_string}"
    end
    
  end
  
end