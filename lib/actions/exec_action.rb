module TaskMaster
  class ExecAction < Action
    
    def command(command)
      @command = command
    end
    
    def arguments(args)
      @args = args
    end
    
    def working_directory(working_dir)
      @working_dir = working_dir
    end
    
    def valid?
      unless (@command && !@command.blank?)
        add_error("#{self.class.name}: Command property is not valid.")
        return false
      end
      true
    end
    
    def to_xml(builder)
      builder.Exec(id_attrs) do
        builder.Command @command if @command
        builder.Arguments @args if @args
        builder.WorkingDirectory @working_dir if @working_dir
      end
    end
    
  end
end