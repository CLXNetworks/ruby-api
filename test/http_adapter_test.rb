require 'test_helper'

class HTTPAdapterTest < MiniTest::Test
  
  def setup
    @http_adapter = CLX::HTTPAdapter.new
  end

  def test_initializer
    assert_instance_of CLX::HTTPAdapter, @http_adapter
  end

end