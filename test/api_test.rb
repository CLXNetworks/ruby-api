require 'test_helper'

class APITest < MiniTest::Test
  
  def setup
    @api = CLX::API.new
  end
  
  # Initializer 
  def test_that_object_is_of_correct_instance
    assert_instance_of CLX::API, @api 
  end

end