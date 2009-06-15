require File.expand_path(File.join(File.dirname(__FILE__), "test_helper"))

class TaskTest < Test::Unit::TestCase
  
  context "Actions" do
    
    setup do
      @task = Task.new
    end
    
    should "raise an exception if the task already has the maximum allowable actions" do
      (1..Task::MAX_ACTIONS).each do |i|
        @task.exec_action { command "notepad.exe" }
      end
      assert_raises Task::MaxActionsReachedException do
        @task.exec_action { command "notepad.exe" }
      end
    end
    
    should "execute the block in the context of the action if a block is given" do
      mock_action = mock()
      mock_action.stubs(:valid?).returns(true)
      mock_action.expects(:command).with("notepad.exe")
      Action.stubs(:get).with(:exec).returns(mock_action)
      blk = Proc.new do 
        command "notepad.exe"
      end
      @task.exec_action &blk
    end
    
    should "only add valid actions to its collection of actions" do
      assert_equal(0, @task.instance_variable_get("@actions").size)
      @task.exec_action do
        command "something"
      end
      assert_equal(1, @task.instance_variable_get("@actions").size)
    end
    
    should "raise an exception if the action is not valid" do
      assert_raises Task::InvalidActionException do
        @task.exec_action do
          
        end
      end
    end
    
  end
  
  context "Triggers" do
    
    setup do
      @task = Task.new
    end
    
    should "execute the block in the context of the trigger if a block is given" do
      mock_trigger = mock()
      mock_trigger.stubs(:valid?).returns(true)
      mock_trigger.expects(:enabled).with(true)
      mock_trigger.expects(:execution_time_limit).with(5.minutes)
      Trigger.stubs(:get).with(:idle).returns(mock_trigger)
      blk = Proc.new do 
        enabled true
        execution_time_limit 5.minutes
      end
      @task.idle_trigger &blk
    end
    
    should "raise an exception if the task already had the maximum allowable triggers" do
      (1..Task::MAX_TRIGGERS).each do |i|
        @task.idle_trigger
      end
      assert_raises Task::MaxTriggersReachedException do
        @task.idle_trigger
      end
    end
    
    should "only add valid triggers to its collection of triggers" do
      assert_equal(0, @task.instance_variable_get("@triggers").size)
      @task.event_trigger do
        subscription "something"
      end
      assert_equal(1, @task.instance_variable_get("@triggers").size)
    end
    
    should "raise an exception if the trigger is not valid" do
      assert_raises Task::InvalidTriggerException do
        @task.event_trigger do
          
        end
      end
    end
    
  end
  
end