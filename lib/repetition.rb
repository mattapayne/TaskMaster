module TaskMaster
  class Repetition
  
    def duration(duration)
      @duration = Duration.new(duration)
    end
  
    def interval(rep_duration)
      @interval = Duration.new(rep_duration)
    end
  
    def stop_at_duration_end(stop)
      @stop_at_duration_end = stop
    end
  
    def to_xml(builder)
      builder.Repetition do
        builder.Interval @interval.to_s if @interval
        builder.Duration @duration.to_s if @duration
        builder.StopAtDurationEnd @stop_at_duration_end if @stop_at_duration_end
      end
    end
  
  end
end