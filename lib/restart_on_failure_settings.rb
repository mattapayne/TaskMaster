module TaskMaster
  class RestartOnFailureSettings
    
    def count(count)
      @count = count
    end
    
    def interval(duration)
      @interval = Duration.new(duration)
    end
    
    def to_xml(builder)
      builder.RestartOnFailure do
        builder.Count @count if @count
        builder.Interval @interval.to_s if @interval
      end
    end
    
  end
end