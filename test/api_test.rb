require 'test_helper'

class APITest < MiniTest::Test
  
  def setup
    @api = CLX::API.new 'username', 'password'
  end
  
  # Initializer 
  def test_that_object_is_of_correct_instance
    assert_instance_of CLX::API, @api 
  end

  def test_initializer_without_arguments_raises_error
    assert_raises ArgumentError do
      CLX::API.new
    end
  end
  
  def test_initializer_with_too_few_arguments_raises_error
    assert_raises ArgumentError do
      CLX::API.new 'username'
    end
  end
  
  def test_initializer_with_too_many_arguments_raises_error
    assert_raises ArgumentError do
      CLX::API.new 'username', 'password', nil, 'one_argument_too_much'
    end
  end

end