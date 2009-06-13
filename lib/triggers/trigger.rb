module TaskMaster
  class Trigger
    include DateHelpers
  
    def self.get(type)
      if type.blank? || !trigger_types.keys.include?(type.to_sym)
        raise "Invalid trigger type: #{type}. Must be one of #{trigger_types.keys.to_sentence}"
      end
      return trigger_types[type.to_sym].new
    end
    
    #default value - override in derived classes
    def valid?
      true
    end
    
    def enabled(is_enabled)
      @enabled = is_enabled
    end
    
    def end_boundary(date)
      @end_boundary = convert_date(date)
    end
    
    def execution_time_limit(duration)
      @exec_time_limit = Duration.new(duration)
    end
    
    def repetition(&block)
      if block_given?
        @repetition = Repetition.new
        @repetition.instance_eval(&block)
      end
    end
    
    def start_boundary(date)
      @start_boundary = convert_date(date)
    end
    
    def to_xml(builder)
      builder.StartBoundary @start_boundary if @start_boundary
      builder.EndBoundary @end_boundary if @end_boundary
      builder.Enabled @enabled if @enabled
      if @repetition
        @repetition.to_xml(builder)
      end
      builder.ExecutionTimeLimit @exec_time_limit.to_s if @exec_time_limit
    end
    
    private
    
    def self.trigger_types
      { :boot => BootTrigger, :calendar => CalendarTrigger, :event => EventTrigger, 
        :idle => IdleTrigger, :logon => LogonTrigger, :registration => RegistrationTrigger, 
        :session_state_change => SessionStateChangeTrigger, :time => TimeTrigger }
    end
    
  end
end