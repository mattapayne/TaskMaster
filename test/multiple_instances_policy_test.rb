require File.expand_path(File.join(File.dirname(__FILE__), "test_helper"))

class MultipleInstancesPolicyTest < Test::Unit::TestCase
  
  context "Initialization" do
    
    should "raise an exception if initialized with an invalid policy" do
      assert_raises ArgumentError do
        MultipleInstancesPolicy.new("blah")
      end
    end
    
    should "NOT raise an exception if passed a valid policy" do
      assert_nothing_raised ArgumentError do
        MultipleInstancesPolicy.new(MultipleInstancesPolicy.queue)
      end
    end
    
  end
  
end