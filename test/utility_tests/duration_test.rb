require File.expand_path(File.join(File.dirname(__FILE__), "..", "test_helper"))

class DurationTest < Test::Unit::TestCase
  
  context "Initialization of a Duration object" do
    
    should "blow up if not initialized with a Fixnum or Float" do
      
      assert_raises ArgumentError do
        Duration.new("A String")
      end
      
    end
    
    should "not blow up if initialized with a Fixnum or Float" do
      assert_nothing_raised do
        Duration.new(1.day)
      end
      
      assert_nothing_raised do
        Duration.new(1.day + 2.hours + 3.minutes + 4.seconds)
      end
    end
    
  end
  
  context "Duration validity" do
    
    should "be invalid if less than 60 seconds" do
      d = Duration.new(59.seconds)
      assert(!d.valid?, "#{d} is valid")
    end
    
    should "be valid if equal to 60 seconds" do
      d = Duration.new(60.seconds)
      assert(d.valid?, "#{d} is not valid")
    end
    
    should "be valid if greater than 60 seconds" do
      d = Duration.new(61.seconds)
      assert(d.valid?, "#{d} is not valid")
    end
    
  end
  
  context "Converting to task notation" do
    
    should "properly convert only seconds" do
      d = Duration.new(10.seconds)
      assert_equal("PT10S", d.to_s, "#{d} is not equal to PT10S")
    end
    
    should "properly convert only minutes" do
      d = Duration.new(10.minutes)
      assert_equal("PT10M", d.to_s, "#{d} is not equal to PT10M")
    end
    
    should "properly convert only hours" do
      d = Duration.new(2.hours)
      assert_equal("PT2H", d.to_s, "#{d} is not equal to PT2H")
    end
    
    should "properly convert minutes and seconds" do
      d = Duration.new(2.minutes + 2.seconds)
      assert_equal("PT2M2S", d.to_s, "#{d} is not equal to PT2M2S")
    end
    
    should "properly convert hours and minutes" do
      d = Duration.new(2.hours + 34.minutes)
      assert_equal("PT2H34M", d.to_s, "#{d} is not equal to PT2H34M")
    end
    
    should "properly convert hours, minutes and seconds" do
      d = Duration.new(2.hours + 2.minutes + 14.seconds)
      assert_equal("PT2H2M14S", d.to_s, "#{d} is not equal to PT2H2M14S")
    end
    
    should "properly convert only days" do
      d = Duration.new(10.days)
      assert_equal("P10DT", d.to_s, "#{d} is not equal to P10DT")
    end
    
    should "properly convert only months" do
      d = Duration.new(10.months)
      assert_equal("P10MT", d.to_s, "#{d} is not equal to P10MT")
    end
    
    should "properly convert only years" do
      d = Duration.new(10.years)
      assert_equal("P10YT", d.to_s, "#{d} is not equal to P10YT")
    end
    
    should "properly convert years and months" do
      d = Duration.new(10.years + 5.months)
      assert_equal("P10Y5MT", d.to_s, "#{d} is not equal to P10Y5MT")
    end
    
    should "properly convert months and days" do
      d = Duration.new(10.months + 3.days)
      assert_equal("P10M3DT", d.to_s, "#{d} is not equal to P10M3DT")
    end
    
    should "properly convert years, months and days" do
      d = Duration.new(10.years + 4.months + 4.days)
      assert_equal("P10Y4M4DT", d.to_s, "#{d} is not equal to P10Y4M4DT")
    end
    
    should "properly convert a random mixture of date and time" do
      d = Duration.new(10.years + 4.days + 1.hour + 56.seconds)
      assert_equal("P10Y4DT1H56S", d.to_s, "#{d} is not equal to P10Y4DT1H56S")
    end
    
  end
  
end