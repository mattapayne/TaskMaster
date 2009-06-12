module TaskMaster
  
  class MultipleInstancesPolicy
    
    MULTIPLE_INSTANCES_POLICIES = ["Parallel", "Queue", "IgnoreNew", "StopExisting"].freeze
    
    def initialize(policy_name)
      unless MultipleInstancesPolicy.valid_policy?(policy_name)
        raise ArgumentError.new("Invalid multiple instances policy: #{policy_name}. Must be one of #{MULTIPLE_INSTANCES_POLICIES.to_sentence}")
      end
      @policy = policy_name
    end
    
    def self.valid_policy?(policy_name)
      (!policy_name.blank? && MULTIPLE_INSTANCES_POLICIES.include?(policy_name.to_s))
    end
    
    def self.parallel
      "Parallel"
    end
    
    def self.queue
      "Queue"
    end
    
    def self.ignore_new
      "IgnoreNew"
    end
    
    def self.stop_existing
      "StopExisting"
    end
    
    def to_s
      @policy
    end
    
  end
  
end