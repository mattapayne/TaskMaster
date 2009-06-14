require File.expand_path(File.join(File.dirname(__FILE__), "test_helper"))

class StateChangeTest < Test::Unit::TestCase
  
  context "Initialization" do
    
    should "raise an exception if initialized with an invalid state" do
      assert_raises ArgumentError do
        StateChange.new("dfgd")
      end
    end
    
    should "NOT raise an exception if initialized with an valid state" do
      assert_nothing_raised do
        StateChange.new(StateChange.console_connect)
      end
    end
    
  end
  
end