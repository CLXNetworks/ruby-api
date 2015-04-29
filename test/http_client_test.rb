require 'test_helper'

class HTTPClientTest < MiniTest::Test
  
  def setup
    http_adapter = CLX::TestAdapter.new
    http_adapter.set_auth('username', 'password')
    @base_url = 'http://base.url.org/api'
    @client = CLX::HTTPClient.new @base_url, http_adapter
  end

  def test_initializer
    assert_instance_of CLX::HTTPClient, @client
  end

  def test_request_resource_list_returns_array_of_open_struct
    response = OpenStruct.new(
      body: '[
        {"id":1,"name":"Foo","network":"Foonetwork","uniqueName":"Foo uniquq","isoCountryCode":"8","operationalState":"active","operationalStatDate":"-0001-11-30 00:00:00","numberOfSubscribers":0},
        {"id":1058,"name":"Bar mobile","network":"Bar Mobile","uniqueName":"Foo Mobile-unique","isoCountryCode":"8","operationalState":"active","operationalStatDate":"-0001-11-30 00:00:00","numberOfSubscribers":0}
      ]',
      code: 200
    )
    @client.http_adapter.response = response
    path = '/operator'
    full_url = @base_url + path

    result = @client.get(path)

    assert_equal result.length, 2
    assert_equal result[0].id, 1
    assert_equal @client.http_adapter.request_url, full_url
    assert_equal @client.http_adapter.request_method, 'GET'
  end

  def test_request_single_resource_returns_open_struct
    response = OpenStruct.new(
      body: '{"id":1,"name":"Foo","network":"Foonetwork","uniqueName":"Foo uniquq","isoCountryCode":"8","operationalState":"active","operationalStatDate":"-0001-11-30 00:00:00","numberOfSubscribers":0}',
      code: 200
    )
    @client.http_adapter.response = response
    path = '/operator/1'
    full_url = @base_url + path

    result = @client.get(path)
    
    assert_equal result.id, 1
    assert_equal @client.http_adapter.request_url, full_url
    assert_equal @client.http_adapter.request_method, 'GET'
  end

  def test_get_request_to_resource_that_does_not_exist_raises_clx_exception_
    response = OpenStruct.new(
      body: '{"error":{"message": "No operator with id: 9999", "code": 3001}}',
      code: 404
    )
    @client.http_adapter.response = response
    path = '/operator/9999'
    full_url = @base_url + path

    assert_raises CLX::CLXAPIException do
      #test http-code == 404
      result = @client.get(path)
    end
    assert_equal @client.http_adapter.request_url, full_url
    assert_equal @client.http_adapter.request_method, 'GET'
  end

  def test_post_returns_data_hash_as_open_struct
    data = {id: 1, key: 'value'}
    response = OpenStruct.new(
      body: data.to_json,
      code: 201
    )
    @client.http_adapter.response = response
    path = '/post-path'
    full_url = @base_url + path

    result = @client.post(path, data)

    assert_equal data[:id], result.id
    assert_equal data[:key], result.key
    assert_equal @client.http_adapter.request_url, full_url
    assert_equal @client.http_adapter.request_method, 'POST'
  end

  def test_put_returns_modified_data_hash_as_open_struct
    data = {id: 1, key: 'value'}
    data[:key] = 'new value'
    response = OpenStruct.new(
      body: data.to_json,
      code: 200
    )
    @client.http_adapter.response = response
    path = '/put-path'
    full_url = @base_url + path

    result = @client.put(path, data)

    assert_equal data[:id], result.id
    assert_equal data[:key], result.key
    assert_equal @client.http_adapter.request_url, full_url
    assert_equal @client.http_adapter.request_method, 'PUT'
  end

  def test_delete_returns_empty_open_struct
    response = OpenStruct.new(
      body: '{}',
      code: 204
    )
    @client.http_adapter.response = response
    path = '/delete-path'
    full_url = @base_url + path

    result = @client.delete(path)

    assert_empty result.to_h
    assert_equal @client.http_adapter.request_url, full_url
    assert_equal @client.http_adapter.request_method, 'DELETE'
  end

  def test_parser_with_invalid_json_raises_clx_exception
    response = OpenStruct.new(
      body: '{not_valid_json \not :at all',
      code: 200
    )
    @client.http_adapter.response = response

    path = '/invalid-json-response'
    full_url = @base_url + path

    assert_raises CLX::CLXException do
      @client.get(path)
    end
    assert_equal @client.http_adapter.request_url, full_url
    assert_equal @client.http_adapter.request_method, 'GET'
  end

  def test_reponse_with_unknown_http_status_code_with_error_raises_clx_api_exception
    response = OpenStruct.new(
      body: '{"message": "strage error", "code": 1234}',
      code: 410
    )
    @client.http_adapter.response = response

    path = '/invalid-unknown-http-code-with-error'
    full_url = @base_url + path

    assert_raises CLX::CLXAPIException do
      @client.get(path)
    end
    assert_equal @client.http_adapter.request_url, full_url
    assert_equal @client.http_adapter.request_method, 'GET'
  end

  def test_response_with_unknown_http_status_code_but_no_errors_raises_clx_api_exception
    response = OpenStruct.new(
      body: '{}',
      code: 410
    )
    @client.http_adapter.response = response

    path = '/invalid-unknown-http-code-without-error'
    full_url = @base_url + path

    assert_raises CLX::CLXAPIException do
      @client.get(path)
    end
    assert_equal @client.http_adapter.request_url, full_url
    assert_equal @client.http_adapter.request_method, 'GET'
  end

end