require 'test_helper'

class HTTPClientTest < MiniTest::Test
  
  def setup
    @client = CLX::HTTPClient.new
  end

  def test_initializer
    assert_instance_of CLX::HTTPClient, @client
  end

end