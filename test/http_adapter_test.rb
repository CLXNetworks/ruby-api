require 'test_helper'

class HTTPAdapterTest < MiniTest::Test
  
  def setup
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
      @http_adapter.get('http://some.url', {query: 'value'}, 'too_many_arguments')
    end
  end

  def test_http_method_get_only_takes_valid_url_as_first_argument
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

  def test_http_method_get_only_accepts_hash_string_or_array_as_argument
    assert_raises CLX::CLXException do
      @http_adapter.get('http://some.url', 123)
    end

    assert_raises CLX::CLXException do
      @http_adapter.get('http://some.url', 12.3)
    end

    assert_raises CLX::CLXException do
      @http_adapter.get('http://some.url', Class.new)
    end

    assert_raises CLX::CLXException do
      @http_adapter.get('http://some.url', Struct.new(:key))
    end

    assert_raises CLX::CLXException do
      @http_adapter.get('http://some.url', OpenStruct.new)
    end
  end

  def test_http_method_get_should_not_be_implemented_yet
    assert_raises NotImplementedError do
      @http_adapter.get('http://some.url')
    end

  end

  # POST
  def test_http_method_post_should_not_be_implemented_yet
    
    assert_raises NotImplementedError do
      @http_adapter.post('http://some.url', {})
    end

  end

  def test_http_method_post_with_no_arguments_raises_error
    assert_raises ArgumentError do
      @http_adapter.post()
    end
  end

  def test_http_method_post_without_data_argument_raises_error
    assert_raises ArgumentError do
      @http_adapter.post('http://some.url')
    end
  end

  def test_http_method_post_with_too_many_arguments_raises_error
    assert_raises ArgumentError do
      @http_adapter.post('http://some.url', {data: 1}, {query: 'value'}, 'too_many_arguments')
    end
  end

  # PUT
  def test_http_method_put_should_not_be_implemented_yet
    assert_raises NotImplementedError do
      @http_adapter.put('http://some.url', {})
    end

  end

  def test_http_method_put_with_no_arguments_should_raise_error
    assert_raises ArgumentError do
      @http_adapter.put()
    end
  end

  def test_http_method_put_without_data_argument_should_raise_error
    assert_raises ArgumentError do
      @http_adapter.put('http://some.url')
    end
  end

  def test_http_method_put_with_too_many_arguments_raises_error
    assert_raises ArgumentError do
      @http_adapter.put('http://some.url', {data: 1}, {query: 'value'}, 'too_many_arguments')
    end
  end

  # DELETE
  def test_http_method_delete_should_not_be_implemented_yet
    assert_raises NotImplementedError do
      @http_adapter.delete('http://some.url')
    end
  end

  def test_http_method_delete_without_argument_should_raise_error
    assert_raises ArgumentError do
      @http_adapter.delete()
    end
  end

  def test_http_method_delete_with_too_many_arguments_should_raise_error
    assert_raises ArgumentError do
      @http_adapter.delete('http://some.url', {query: 'value'}, 'too_many_arguments')
    end
  end

end