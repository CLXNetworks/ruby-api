require 'test_helper'

class HTTPClientTest < MiniTest::Test
  
  def setup
    http_adapter = CLX::TestAdapter.new
    http_adapter.set_auth('username', 'password')
    @client = CLX::HTTPClient.new 'http://some.url.org', http_adapter
  end

  def test_initializer
    assert_instance_of CLX::HTTPClient, @client
  end

  def test_request_resource_list_returns_array_of_open_struct
    result = @client.get('/operator/')

    assert_equal result.length, 2
    assert_equal result[0].id, 1
  end

  def test_request_single_resource_returns_open_struct
    result = @client.get('/operator/1')
    
    assert_equal result.id, 1
  end

  def test_get_request_to_resource_that_does_not_exist_raises_clx_exception
    assert_raises CLX::CLXAPIException do
      result = @client.get('/operator/9999')
    end
  end

  def test_post_returns_data_hash_as_open_struct
    data = {id: 1, key: 'value'}
    result = @client.post('/post-path', data)

    assert_equal data[:id], result.id
    assert_equal data[:key], result.key
  end

  def test_put_returns_modified_data_hash_as_open_struct
    data = {id: 1, key: 'value'}
    data[:key] = 'new value'
    result = @client.put('/put-path', data)

    assert_equal data[:id], result.id
    assert_equal data[:key], result.key
  end

  def test_delete_returns_empty_open_struct
    result = @client.delete('/delete-path')

    assert_empty result.to_h
  end

  def test_parser_with_invalid_json_raises_clx_exception
    assert_raises CLX::CLXException do
      @client.get('/invalid-json-response')
    end
  end

  def test_unknown_http_status_code_error_raises_clx_exception
    assert_raises CLX::CLXAPIException do
      @client.get('/invalid-unknown-http-code-with-error')
    end

    assert_raises CLX::CLXAPIException do
      @client.get('/invalid-unknown-http-code-without-error')
    end
  end

end