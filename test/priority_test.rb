require File.expand_path(File.join(File.dirname(__FILE__), "test_helper"))

class PriorityTest < Test::Unit::TestCase
  
  context "Initialization" do
    
    should "raise an exception if passed an invalid priority" do
      assert_raises ArgumentError do
        Priority.new(22)
      end
    end
    
    should "NOT raise an exception if passed a valid priority" do
      assert_nothing_raised do
        Priority.new(Priority.normal)
      end
    end
    
    should "be able to handle string priorities" do
      assert_nothing_raised do
        Priority.new("5")
      end
    end
    
  end
  
end