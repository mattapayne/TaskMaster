require File.expand_path(File.join(File.dirname(__FILE__), "..", "test_helper"))

class ActionTest < Test::Unit::TestCase
  
  context "Getting instances of Actions" do
    
    should "return a ComAction when passed the proper type" do
      assert_instance_of(ComAction, Action.get(:com))
    end
    
    should "return an ExecAction when passed the proper type" do
      assert_instance_of(ExecAction, Action.get(:exec))
    end
    
    should "return an EmailAction when passed the proper type" do
      assert_instance_of(EmailAction, Action.get(:email))
    end
    
    should "return a ShowMessageAction when passed the proper type" do
      assert_instance_of(ShowMessageAction, Action.get(:show_message))
    end
    
    should "raise an ArgumentError if passed an unknown action type" do
      assert_raises ArgumentError do
        Action.get(:something)
      end
    end
    
    should "raise an ArgumentError if passed a nil action type" do
      assert_raises ArgumentError do
        Action.get(nil)
      end
    end
    
    should "raise an ArgumentError if passed a blank type" do
      assert_raises ArgumentError do
        Action.get("")
      end
    end
    
    should "be able to handle type as a string" do
      assert_instance_of(ShowMessageAction, Action.get("show_message"))
    end
    
  end
  
end