module TaskMaster
  class BaseSettings
    
    def network_profile_name(name)
      @network_profile_name = name
    end
    
    def idle_settings(&block)
      if block_given?
        @idle_settings ||= IdleSettings.new
        @idle_settings.instance_eval(&block)
      end
    end
    
    def enabled(enabled)
      @enabled = enabled
    end
    
    def priority(priority_value)
      @priority = Priority.new(priority_value)
    end
    
    def multiple_instances_policy(policy_name)
      @multiple_instances_policy = MultipleInstancesPolicy.new(policy_name)
    end
    
    def network_settings(&block)
      if block_given?
        @network_settings ||= NetworkSettings.new
        @network_settings.instance_eval(&block)
      end
    end
    
    def restart_on_failure(&block)
      if block_given?
        @restart_on_failure_settings ||= RestartOnFailureSettings.new
        @restart_on_failure_settings.instance_eval(&block)
      end
    end
    
    def wake_to_run(run)
      @wake_to_run = run
    end
    
    def stop_if_going_on_batteries(stop)
      @stop_if_going_on_batteries = stop
    end
    
    def start_when_avaliable(start)
      @start_when_avaliable = start
    end
    
    def run_only_if_network_is_avaliable(run)
      @run_only_if_network_is_avaliable = run
    end
    
    def run_only_if_idle(run)
      @run_only_if_idle = run
    end
    
    def hidden(is_hidden)
      @hidden = is_hidden
    end
    
    def allow_start_on_demand(allow)
      @allow_start_on_demand = allow
    end
    
    def allow_hard_terminate(allow)
      @allow_hard_terminate = allow
    end
    
    def delete_expired_task_after(duration)
      @delete_expired_task_after = Duration.new(duration)
    end
    
    def disallow_start_if_on_batteries(disallow)
      @disallow_start_if_on_batteries = disallow
    end
    
    def execution_time_limit(duration)
      @execution_time_limit = Duration.new(duration)
    end
    
    def run_only_if_network_available(run)
      @run_only_if_network_available = run
    end
    
    def start_when_available(start)
      @start_when_available = start
    end
    
    def to_xml(builder)
      builder.AllowHardTerminate @allow_hard_terminate if @allow_hard_terminate
      builder.AllowStartOnDemand @allow_start_on_demand if @allow_start_on_demand
      builder.DeleteExpiredTaskAfter @delete_expired_task_after.to_s if @delete_expired_task_after
      builder.DisallowStartIfOnBatteries @disallow_start_if_on_batteries if @disallow_start_if_on_batteries
      builder.Enabled @enabled if @enabled
      builder.ExecutionTimeLimit @execution_time_limit.to_s if @execution_time_limit
      builder.Hidden @hidden if @hidden
      if @idle_settings
        @idle_settings.to_xml(builder)
      end
      builder.MultipleInstancesPolicy @multiple_instances_policy.to_s if @multiple_instances_policy
      builder.NetworkProfileName @network_profile_name if @network_profile_name
      if @network_settings
        @network_settings.to_xml(builder)
      end
      builder.Priority @priority.to_s if @priority
      if @restart_on_failure_settings
        @restart_on_failure_settings.to_xml(builder)
      end
      builder.RunOnlyIfIdle @run_only_if_idle if @run_only_if_idle
      builder.RunOnlyIfNetworkAvailable @run_only_if_network_available if @run_only_if_network_available
      builder.StartWhenAvaliable @start_when_available if @start_when_available
      builder.StopIfGoingOnBatteries @stop_if_going_on_batteries if @stop_if_going_on_batteries
      builder.WakeToRun @wake_to_run if @wake_to_run
    end
    
  end
end