require 'test_helper'

class HTTPClientTest < MiniTest::Test
  
  def setup
    http_adapter = CLX::TestAdapter.new
    @client = CLX::HTTPClient.new 'http://some.url.org', http_adapter
  end

  def test_initializer
    assert_instance_of CLX::HTTPClient, @client
  end

  def test_get_with_operator_path_returns_array_of_open_struct_with_operators_content
    result = @client.get('/operator')

    assert_equal result.length, 2
    assert_equal result[0].id, 1
  end

  def test_get_with_operator_id_1_path_returns_open_struct
    result = @client.get('/operator/1')
    assert_equal result.id, 1
  end

  def test_get_with_operator_id_that_doesn_not_exist_raises_clx_api_exception_404
    assert_raises CLX::CLXAPIException do
      result = @client.get('/operator/9999')
    end
  end

end