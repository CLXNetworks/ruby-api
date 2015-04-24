require 'test_helper'

class HTTPAdapterTest < MiniTest::Test
  
  def setup
    @base_url = 'https://httpbin.org'
    @http_adapter = CLX::HTTPAdapter.new
  end

  def test_initializer
    assert_instance_of CLX::HTTPAdapter, @http_adapter
  end

  def test_set_auth_method_set_username_and_password
    @http_adapter.setAuth('new_username', 'new_password')
    assert_equal @http_adapter.username, 'new_username'
    assert_equal @http_adapter.password, 'new_password'
  end

  def test_set_auth_only_accepts_non_empty_strings
    assert_raises CLX::CLXException do
      @http_adapter.setAuth(1, 1)
    end
    assert_raises CLX::CLXException do
      @http_adapter.setAuth('', '')
    end
    assert_raises CLX::CLXException do
      @http_adapter.setAuth({username: 'username'}, password: 'password')
    end
  end

  # GET method
  def test_http_method_with_no_arguments_raises_error
    assert_raises ArgumentError do
      @http_adapter.get()
    end
  end

  def test_http_method_get_with_too_many_arguments_raises_error
    assert_raises ArgumentError do
      uri = URI(@base_url + '/get')
      @http_adapter.get(uri, 'too_many_arguments')
    end
  end

  def test_http_methods_only_accepts_uri_object_as_first_argument
    assert_raises CLX::CLXException do
      @http_adapter.get(123)
    end

    assert_raises CLX::CLXException do
      @http_adapter.get('')
    end

    assert_raises CLX::CLXException do
      @http_adapter.get({key: 'value'})
    end
  end

  def test_get_request_with_valid_url_returns_http_ok
    uri = URI(@base_url + '/get')
    response = @http_adapter.get(uri)
    assert_instance_of Net::HTTPOK, response
  end

  # POST

  def test_http_method_post_with_no_arguments_raises_error
    assert_raises ArgumentError do
      @http_adapter.post()
    end
  end

  def test_http_method_post_without_data_argument_raises_error
    assert_raises ArgumentError do
      uri = URI(@base_url)
      @http_adapter.post(uri)
    end
  end

  def test_http_method_post_with_too_many_arguments_raises_error
    assert_raises ArgumentError do
      uri = URI(@base_url + '/post')
      @http_adapter.post(uri, {data: 1}, 'too_many_arguments')
    end
  end

  def test_post_request_with_valid_url_returns_http_ok
    uri = URI(@base_url + '/post')
    response = @http_adapter.post(uri, {data: 1})
    assert_instance_of Net::HTTPOK, response
  end

  # PUT

  def test_http_method_put_with_no_arguments_should_raise_error
    assert_raises ArgumentError do
      @http_adapter.put()
    end
  end

  def test_http_method_put_without_data_argument_should_raise_error
    assert_raises ArgumentError do
      uri = URI(@base_url + '/put')
      @http_adapter.put(uri)
    end
  end

  def test_http_method_put_with_too_many_arguments_raises_error
    assert_raises ArgumentError do
      uri = URI(@base_url + '/put')
      @http_adapter.put(uri, {data: 1}, 'too_many_arguments')
    end
  end

  def test_put_request_with_valid_url_returns_http_ok
    uri = URI(@base_url + '/put')
    response = @http_adapter.put(uri, {data: 1})
    assert_instance_of Net::HTTPOK, response
  end

  # DELETE
  def test_http_method_delete_without_argument_should_raise_error
    assert_raises ArgumentError do
      @http_adapter.delete()
    end
  end

  def test_http_method_delete_with_too_many_arguments_should_raise_error
    assert_raises ArgumentError do
      uri = URI(@base_url + '/delete')
      @http_adapter.delete(uri, 'too_many_arguments')
    end
  end
  def test_delete_request_with_valid_url_returns_http_ok
    uri = URI(@base_url + '/delete')
    response = @http_adapter.delete(uri)
    assert_instance_of Net::HTTPOK, response
  end

  # Manipulated adapter
  def test_manipulated_adapter_with_invlaid_http_method_raises_clx_exception
    def @http_adapter.fake_method(uri)
      execute('FAKE_HTTP_METHOD', uri)
    end

    assert_raises CLX::CLXException do
      uri = URI(@base_url + '/get')
      response = @http_adapter.fake_method(uri)
    end

  end

end