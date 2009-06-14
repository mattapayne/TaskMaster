require File.expand_path(File.join(File.dirname(__FILE__), "test_helper"))

class TaskPrincipalTest < Test::Unit::TestCase
  
  context "Creating XML" do
  
    setup do
      @b = mock()
      @tp = TaskPrincipal.new
    end
    
    should "create a Pricipals element" do
      @b.expects(:Principals)
      @tp.to_xml(@b)
    end
    
    should "create a Principal element" do
      @b.stubs(:Principals) do
        @b.expects(:Principal)
      end
      @tp.to_xml(@b)
    end
    
    should "create a UserId element if userid is set" do
      @b.stubs(:Principals) do
        @b.stubs(:Principal) do
          @b.expects(:UserId)
        end
      end
      @tp.userid 10
      @tp.to_xml(@b)
    end
    
    should "create a GroupId element if groupid is set" do
      @b.stubs(:Principals) do
        @b.stubs(:Principal) do
          @b.expects(:GroupId)
        end
      end
      @tp.groupid 10
      @tp.to_xml(@b)
    end
    
    should "create a LogonType element if logon_type is set" do
      @b.stubs(:Principals) do
        @b.stubs(:Principal) do
          @b.expects(:LogonType)
        end
      end
      @tp.logon_type LogonType.password
      @tp.to_xml(@b)
    end
    
    should "create a DisplayName element if dislay_name is set" do
      @b.stubs(:Principals) do
        @b.stubs(:Principal) do
          @b.expects(:DisplayName)
        end
      end
      @tp.display_name "Something"
      @tp.to_xml(@b)
    end
    
    should "NOT create a UserId element if userid is NOT set" do
      @b.stubs(:Principals) do
        @b.stubs(:Principal) do
          @b.expects(:UserId).never
        end
      end
      @tp.to_xml(@b)
    end
    
    should "NOT create a GroupId element if groupid is NOT set" do
      @b.stubs(:Principals) do
        @b.stubs(:Principal) do
          @b.expects(:GroupId).never
        end
      end
      @tp.to_xml(@b)
    end
    
    should "NOT create a LogonType element if logon_type is NOT set" do
      @b.stubs(:Principals) do
        @b.stubs(:Principal) do
          @b.expects(:LogonType).never
        end
      end
      @tp.to_xml(@b)
    end
    
    should "NOT create a DisplayName element if duslay_name is NOT set" do
      @b.stubs(:Principals) do
        @b.stubs(:Principal) do
          @b.expects(:DisplayName).never
        end
      end
      @tp.to_xml(@b)
    end
    
  end
  
  context "Exceptions" do
    
    setup do
      @tp = TaskPrincipal.new
    end
    
    should "raise an exception if logon_type is invalid" do
      assert_raises ArgumentError do
        @tp.logon_type "dfssf"
      end
    end
    
  end
  
end