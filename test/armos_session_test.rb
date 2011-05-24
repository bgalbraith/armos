$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'armos_session'

class ArmosSessionTest < Test::Unit::TestCase
  def test_initialization
    ArmosSession.new
    assert(true)
  end
end
