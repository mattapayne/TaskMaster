module TaskMaster
  class Priority
    
    REALTIME = 0..0
    HIGH = 1..1
    ABOVE_NORMAL = 2..3
    NORMAL = 4..6
    BELOW_NORMAL = 7..8
    IDLE = 9..10
    
    PRIORITIES = [REALTIME, HIGH, ABOVE_NORMAL, NORMAL, BELOW_NORMAL, IDLE].freeze
    
    def initialize(priority_value)
      unless Priority.valid_priority?(priority_value)
        raise ArgumentError.new("Invalid priority: #{priority_value}. Must be one of #{PRIORITIES.to_sentence}")
      end
      @priority_value = priority_value
    end
    
    def self.valid_priority?(priority)
      return false if priority.blank?
      PRIORITIES.each do |range|
        return true if range.include?(priority.to_i)
      end
      return false
    end
    
    def self.realtime
      0
    end
    
    def self.high
      1
    end
    
    def self.above_normal
      2
    end
      
    def self.normal
      5
    end
    
    def self.below_normal
      7
    end
    
    def self.idle
      10
    end
    
    def to_s
      @priority_value.to_s
    end
    
  end
end