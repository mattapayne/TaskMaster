module TaskMaster
  class Task
    include DateHelpers
    
    MAX_ACTIONS = 32
    MAX_TRIGGERS = 48
    
    class MaxActionsReachedException < RuntimeError; end
    
    class MaxTriggersReachedException < RuntimeError; end
    
    class InvalidActionException < RuntimeError; end
    
    class InvalidTriggerException < RuntimeError; end
    
    def initialize
      @actions = []
      @triggers = []
    end
    
    def file_name
      @filename
    end
    
    def name(task_name)
      @filename = task_name
    end
    
    def description(task_descr)
      @description = task_descr
    end
    
    def date(task_date)
      @date = convert_date(task_date)
    end
    
    def author(task_author)
      @author = task_author
    end
    
    def version(task_version)
      @version = task_version
    end
    
    def documentation(task_doc)
      @documentation = task_doc
    end
    
    def security_descriptor(security_desc)
      @security_descriptor = security_desc
    end
    
    def source(task_source)
      @source = task_source
    end
    
    def uri(task_uri)
      @uri = task_uri
    end
    
    def data(task_data)
      @data = task_data
    end
    
    def settings(&block)
      if block_given?
        @settings ||= TaskSettings.new
        @settings.instance_eval(&block)
      end
    end
    
    def principal(&block)
      if block_given?
        @principal ||= TaskPrincipal.new
        @principal.instance_eval(&block)
      end
    end
    
    def exec_action(&block)
      action(:exec, &block)
    end
    
    def com_action(&block)
      action(:com, &block)
    end
    
    def email_action(&block)
      action(:email, &block)
    end
    
    def show_message_action(&block)
      action(:show_message, &block)
    end
    
    def action(type = :exec, &block)
      unless @actions.size >= MAX_ACTIONS
        action = Action.get(type)
        if block_given?
          action.instance_eval(&block)
        end
        unless action.valid?
          raise InvalidActionException.new("Invalid action: #{action.class.name}")
        end
        @actions << action
      else
        raise MaxActionsReachedException.new("You may only have a maximum of #{MAX_ACTIONS} actions.")
      end
    end
    
    def boot_trigger(&block)
      trigger(:boot, &block)
    end
    
    def calendar_trigger(&block)
      trigger(:calendar, &block)
    end
    
    def event_trigger(&block)
      trigger(:event, &block)
    end
    
    def idle_trigger(&block)
      trigger(:idle, &block)
    end
    
    def logon_trigger(&block)
      trigger(:logon, &block)
    end
    
    def registration_trigger(&block)
      trigger(:registration, &block)
    end
    
    def session_state_change_trigger(&block)
      trigger(:session_state_change, &block)
    end
    
    def time_trigger(&block)
      trigger(:time, &block)
    end
    
    def trigger(type, &block)
      unless @triggers.size >= MAX_TRIGGERS
        trigger = Trigger.get(type)
        if block_given?
          trigger.instance_eval(&block)
        end
        unless trigger.valid?
          raise InvalidTriggerException.new("Invalid trigger: #{trigger.class.name}")
        end
        @triggers << trigger
      else
        raise MaxTriggersReachedException.new("You may only have a maximum of #{MAX_TRIGGERS} triggers.")
      end
    end
    
    def to_xml(b)
      b.Task(:xmlns => "http://schemas.microsoft.com/windows/2004/02/mit/task") do
        b.RegistrationInfo do
          b.Date @date if @date
          b.Author @author if @author
          b.Version @version if @version
          b.Description @description if @description
          b.Source @source if @source
          b.Uri @uri if @uri
          b.Documentation @documentation if @documentation
          b.SecurityDescriptor @security_descriptor if @security_descriptor
        end
        b.Data @data if @data
        unless @triggers.empty?
          b.Triggers do
            @triggers.each do |t|
              t.to_xml(b)
            end
          end
        end
        unless @actions.empty?
          b.Actions do
            @actions.each do |a|
              a.to_xml(b)
            end
          end
        end
        unless @settings.nil?
          @settings.to_xml(b)
        end
        unless @principal.nil?
          @principal.to_xml(b)
        end
      end
      b.target!
    end
    
  end
end