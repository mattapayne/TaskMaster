require File.expand_path(File.join(File.dirname(__FILE__), "..", 'lib', 'task_master'))
require 'test/unit'

begin
  require 'shoulda'
rescue LoadError
  warn "To test WinSched you need the shoulda gem"
  warn "$ sudo gem install thoughtbot-shoulda"
  exit(1)
end

begin
  require 'mocha'
rescue LoadError
  warn "To test WinSched you need the mocha gem"
  warn "$ sudo gem install mocha"
  exit(1)
end

class Test::Unit::TestCase
  include TaskMaster
end