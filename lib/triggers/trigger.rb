module TaskMaster
  class Trigger
    include DateHelpers
    
    TRIGGER_TYPES = [:boot, :calendar, :event, :idle, :logon, :registration, :session_state_change, :time].freeze
    
    def self.get(type)
      if type.blank? || !TRIGGER_TYPES.include?(type.to_sym)
        raise "Invalid trigger type: #{type}. Must be one of #{TRIGGER_TYPES.to_sentence}"
      end
      type = type.to_sym
      trigger = nil
      case type
        when :boot
          trigger = BootTrigger.new
        when :calendar
          trigger = CalendarTrigger.new
        when :event
          trigger = EventTrigger.new
        when :idle
          trigger = IdleTrigger.new
        when :logon
          trigger = LogonTrigger.new
        when :registration
          trigger = RegistrationTrigger.new
        when :session_state_change
          trigger = SessionStateChangeTrigger.new
        when :time
          trigger = TimeTrigger.new
      end
      trigger
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
    
  end
end