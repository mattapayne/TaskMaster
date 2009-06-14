require File.expand_path(File.join(File.dirname(__FILE__), "test_helper"))

class LogonTypeTest < Test::Unit::TestCase
  
  context "Initialization" do
    
    should "raise an exception if initialized with an invalid logon type" do
      assert_raises ArgumentError do
        LogonType.new("blah")
      end
    end
    
    should "NOT raise an exception if passed a valid logon type" do
      assert_nothing_raised ArgumentError do
        LogonType.new(LogonType.password)
      end
    end
    
  end
  
end