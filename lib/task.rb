module TaskMaster
  class Task
    include DateHelpers
    
    MAX_ACTIONS = 32
    MAX_TRIGGERS = 48
    
    def initialize
      @actions = []
      @triggers = []
    end
    
    def file_name
      @filename
    end
    
    def name(name)
      @filename = name
    end
    
    def description(descr)
      @description = descr
    end
    
    def date(date)
      @date = convert_date(date)
    end
    
    def author(author)
      @author = author
    end
    
    def version(version)
      @version = version
    end
    
    def documentation(doc)
      @documentation = doc
    end
    
    def security_descriptor(security_desc)
      @security_descriptor = security_desc
    end
    
    def source(source)
      @source = source
    end
    
    def uri(value)
      @uri = value
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
      if block_given?
        unless @actions.size >= MAX_ACTIONS
          action = Action.get(type)
          action.instance_eval(&block)
          unless action.valid?
            raise "Invalid action"
          end
          @actions << action
        else
          raise "You may only have a maximum of #{MAX_ACTIONS} actions."
        end
      else
        raise "You must provide a block to configure the action."
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
      if block_given?
        unless @triggers.size >= MAX_TRIGGERS
          trigger = Trigger.get(type)
          trigger.instance_eval(&block)
          unless trigger.valid?
            raise "Invalid trigger"
          end
          @triggers << trigger
        else
          raise "You may only have a maximum of #{MAX_TRIGGERS} triggers."
        end
      else
        raise "You must supply a block to configure the trigger."
      end
    end
    
    def to_xml
      b = Builder::XmlMarkup.new(:index => 1)
      b.instruct!(:xml, :encoding => nil)
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