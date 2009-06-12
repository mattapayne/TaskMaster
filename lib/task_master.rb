require 'rubygems'
require 'builder'
require 'active_support'
local_path = File.expand_path(File.dirname(__FILE__))
['utility/duration', 'utility/date_helpers', 'idle_settings', 'base_settings', 'task_settings', 'network_settings', 'repetition',
  'restart_on_failure_settings', 'task_principal', 'actions/action', 'actions/com_action', 'actions/exec_action', 
  'actions/email_action', 'actions/show_message_action', 'utility/calendar_helper','triggers/trigger',
  'triggers/boot_trigger', 'triggers/calendar_trigger', 'triggers/event_trigger', 'triggers/idle_trigger',
  'triggers/logon_trigger', 'triggers/registration_trigger', 'triggers/session_state_change_trigger',
  'triggers/time_trigger', 'task'].each do |f|
    require File.join(local_path, f)
  end

module TaskMaster
  
  @@tasks = []
  
  def self.create_tasks(&block)
     if block_given?
       self.instance_eval(&block)
     else
       raise "You must supply a block to begin creating tasks."
     end
  end
  
  def self.task( &block)
    if block_given?
      task = Task.new
      task.instance_eval(&block)
      @@tasks << task
    else
      raise "You must supply a block to configure a task."
    end
  end
  
  def self.to_xml(output_path=".")
    @@tasks.each do |t|
      xml = t.to_xml
      File.open(File.join(output_path, "#{t.file_name}.xml"), 'w') { |f| f.write(xml) }
    end
  end
  
end