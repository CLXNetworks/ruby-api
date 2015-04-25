require 'test_helper'

class HTTPAdapterTest < MiniTest::Test
  
  def setup
    @https_url = 'https://httpbin.org'
    @http_url = 'http://httpbin.org'
    @http_adapter = CLX::HTTPAdapter.new
  end

  def test_initializer
    assert_instance_of CLX::HTTPAdapter, @http_adapter
  end

  def test_set_auth_method_set_username_and_password
    @http_adapter.set_auth('new_username', 'new_password')
    assert_equal @http_adapter.username, 'new_username'
    assert_equal @http_adapter.password, 'new_password'
  end

  def test_set_auth_only_accepts_non_empty_strings
    assert_raises CLX::CLXException do
      @http_adapter.set_auth(1, 1)
    end
    assert_raises CLX::CLXException do
      @http_adapter.set_auth('', '')
    end
    assert_raises CLX::CLXException do
      @http_adapter.set_auth({username: 'username'}, password: 'password')
    end
  end

  def test_basic_auth_via_https_get_returns_http_ok
    @http_adapter.set_auth('user', 'pass')
    uri = URI(@https_url + '/basic-auth/user/pass')
    response = @http_adapter.get(uri)
    assert_instance_of Net::HTTPOK, response
  end

  def test_basic_auth_via_http_get_returns_http_ok
    @http_adapter.set_auth('user', 'pass')
    uri = URI(@http_url + '/basic-auth/user/pass')
    response = @http_adapter.get(uri)
    assert_instance_of Net::HTTPOK, response
  end

  def test_basic_auth_with_incorrect_credentials_via_https_returns_http_unauthorized
    @http_adapter.set_auth('wrong_username', 'wrong_password')
    uri = URI(@https_url + '/basic-auth/user/passwd')
    response = @http_adapter.get(uri)
    assert_instance_of Net::HTTPUnauthorized, response
  end

  def test_basic_auth_with_incorrect_credentials_via_http_returns_http_unauthorized
    @http_adapter.set_auth('wrong_username', 'wrong_password')
    uri = URI(@http_url + '/basic-auth/user/passwd')
    response = @http_adapter.get(uri)
    assert_instance_of Net::HTTPUnauthorized, response
  end

  # GET method
  def test_get_with_no_arguments_raises_argument_error
    assert_raises ArgumentError do
      @http_adapter.get()
    end
  end

  def test_get_with_too_many_arguments_raises_argument_error
    assert_raises ArgumentError do
      uri = URI(@https_url + '/get')
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

  def test_https_get_request_with_valid_url_returns_http_ok
    uri = URI(@https_url + '/get')
    response = @http_adapter.get(uri)
    assert_instance_of Net::HTTPOK, response
  end

  def test_http_get_request_with_valid_url_returns_http_ok
    uri = URI(@http_url + '/get')
    response = @http_adapter.get(uri)
    assert_instance_of Net::HTTPOK, response
  end

  # POST

  def test_post_with_no_arguments_raises_argument_error
    assert_raises ArgumentError do
      @http_adapter.post()
    end
  end

  def test_post_without_data_argument_raises_argument_error
    assert_raises ArgumentError do
      uri = URI(@https_url)
      @http_adapter.post(uri)
    end
  end

  def test_post_with_too_many_arguments_raises_argument_error
    assert_raises ArgumentError do
      uri = URI(@https_url + '/post')
      @http_adapter.post(uri, {data: 1}, 'too_many_arguments')
    end
  end

  def test_https_post_request_with_valid_url_returns_http_ok
    uri = URI(@https_url + '/post')
    response = @http_adapter.post(uri, {data: 1})
    response_types = [Net::HTTPOK, Net::HTTPCreated]
    assert_includes response_types, response.class
  end

  def test_http_post_request_with_valid_url_returns_http_ok
    uri = URI(@http_url + '/post')
    response = @http_adapter.post(uri, {data: 1})
    response_types = [Net::HTTPOK, Net::HTTPCreated]
    assert_includes response_types, response.class
  end

  # PUT

  def test_put_with_no_arguments_should_raise_argument_error
    assert_raises ArgumentError do
      @http_adapter.put()
    end
  end

  def test_put_without_data_argument_should_raise_argument_error
    assert_raises ArgumentError do
      uri = URI(@https_url + '/put')
      @http_adapter.put(uri)
    end
  end

  def test_put_with_too_many_arguments_raises_argument_error
    assert_raises ArgumentError do
      uri = URI(@https_url + '/put')
      @http_adapter.put(uri, {data: 1}, 'too_many_arguments')
    end
  end

  def test_https_put_request_with_valid_url_returns_http_ok
    uri = URI(@https_url + '/put')
    response = @http_adapter.put(uri, {data: 1})
    assert_instance_of Net::HTTPOK, response
  end

  def test_http_put_request_with_valid_url_returns_http_ok
    uri = URI(@http_url + '/put')
    response = @http_adapter.put(uri, {data: 1})
    assert_instance_of Net::HTTPOK, response
  end

  # DELETE
  def test_delete_without_argument_should_raise_argument_error
    assert_raises ArgumentError do
      @http_adapter.delete()
    end
  end

  def test_delete_with_too_many_arguments_should_raise_argument_error
    assert_raises ArgumentError do
      uri = URI(@https_url + '/delete')
      @http_adapter.delete(uri, 'too_many_arguments')
    end
  end
  
  def test_https_delete_request_with_valid_url_returns_http_ok
    uri = URI(@https_url + '/delete')
    response = @http_adapter.delete(uri)
    response_types = [Net::HTTPOK, Net::HTTPNoContent]
    assert_includes response_types, response.class
  end

  def test_http_delete_request_with_valid_url_returns_http_ok
    uri = URI(@http_url + '/delete')
    response = @http_adapter.delete(uri)
    response_types = [Net::HTTPOK, Net::HTTPNoContent]
    assert_includes response_types, response.class
  end

  # Manipulated adapter
  def test_manipulated_adapter_with_invlaid_http_method_raises_clx_exception
    def @http_adapter.fake_method(uri)
      execute('FAKE_HTTP_METHOD', uri)
    end

    assert_raises CLX::CLXException do
      uri = URI(@https_url + '/get')
      response = @http_adapter.fake_method(uri)
    end

  end

end