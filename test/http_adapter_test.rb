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

  def test_http_methods_with_wrong_number_of_arguments_throws_Argument_Error

    # GET
    assert_raises ArgumentError do
      @http_adapter.get()
    end

    assert_raises ArgumentError do
      @http_adapter.get('http://some.url', {query: 'value'}, 'too_many_arguments')
    end

    # POST
    assert_raises ArgumentError do
      @http_adapter.post()
    end

    assert_raises ArgumentError do
      @http_adapter.post('http://some.url')
    end

    assert_raises ArgumentError do
      @http_adapter.post('http://some.url', {data: 1}, {query: 'value'}, 'too_many_arguments')
    end

    # PUT
    assert_raises ArgumentError do
      @http_adapter.put()
    end

    assert_raises ArgumentError do
      @http_adapter.put('http://some.url')
    end

    assert_raises ArgumentError do
      @http_adapter.put('http://some.url', {data: 1}, {query: 'value'}, 'too_many_arguments')
    end

    # DELETE
    assert_raises ArgumentError do
      @http_adapter.delete()
    end

    assert_raises ArgumentError do
      @http_adapter.delete('http://some.url', {query: 'value'}, 'too_many_arguments')
    end

  end

  def test_http_method_get

    assert_raises NotImplementedError do
      @http_adapter.get('http://some.url')
    end

  end

  def test_http_method_post
    
    assert_raises NotImplementedError do
      @http_adapter.post('http://some.url', {})
    end

  end

  def test_http_method_put

    assert_raises NotImplementedError do
      @http_adapter.put('http://some.url', {})
    end

  end

  def test_http_method_delete

    assert_raises NotImplementedError do
      @http_adapter.delete('http://some.url')
    end

  end

end