require 'test_helper'

class HTTPClientTest < MiniTest::Test
  
  def setup
    http_adapter = CLX::TestAdapter.new
    @client = CLX::HTTPClient.new 'http://some.url.org', http_adapter
  end

  def test_initializer
    assert_instance_of CLX::HTTPClient, @client
  end

end