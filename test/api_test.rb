require 'test_helper'

class APITest < MiniTest::Test
  
  def setup
    http_adapter = CLX::TestAdapter.new
    @api = CLX::API.new 'username', 'password', http_adapter
  end
  
  # Initializer 
  def test_that_object_is_of_correct_instance
    assert_instance_of CLX::API, @api 
  end

  def test_initializer_without_arguments_raises_error
    assert_raises ArgumentError do
      CLX::API.new
    end
  end
  
  def test_initializer_with_too_few_arguments_raises_error
    assert_raises ArgumentError do
      CLX::API.new 'username'
    end
  end
  
  def test_initializer_with_too_many_arguments_raises_error
    assert_raises ArgumentError do
      CLX::API.new 'username', 'password', nil, 'one_argument_too_much'
    end
  end

  def test_initializer_argument_username_not_string_raises_CLX_exception
    assert_raises CLX::CLXException do
      CLX::API.new 1, 'a_password'
    end
    
    assert_raises CLX::CLXException do
      @user = {username: 'a_username'}
      CLX::API.new @user, 'a_password'
    end
    
    assert_raises CLX::CLXException do
      CLX::API.new nil, 'a_password'
    end
  end

  def test_initializer_argument_password_not_string_raises_CLX_exception
    assert_raises CLX::CLXException do
      CLX::API.new 'a_username', 1
    end
    
    assert_raises CLX::CLXException do
      @password = {password: 'a_password'}
      CLX::API.new 'a_username', @password
    end
    
    assert_raises CLX::CLXException do
      CLX::API.new 'a_username', nil
    end
  end

  #Public setter methods
  def test_setting_auth_credentials_works
    adapter = @api.http_client.http_adapter
    @api.set_auth('new_username', 'new_password')
    assert_equal adapter.username, 'new_username'
    assert_equal adapter.password, 'new_password'
  end

  def test_setting_base_url_works
    client = @api.http_client
    @api.set_base_url('http://new.url')
    assert_equal client.base_url, 'http://new.url'
  end

  # Get Operators test
  def test_get_operators_returns_list_of_operators
    response = OpenStruct.new(
      body: '[
        {"id":1,"name":"Foo","network":"Foonetwork","uniqueName":"Foo uniquq","isoCountryCode":"8","operationalState":"active","operationalStatDate":"-0001-11-30 00:00:00","numberOfSubscribers":0},
        {"id":1058,"name":"Bar mobile","network":"Bar Mobile","uniqueName":"Foo Mobile-unique","isoCountryCode":"8","operationalState":"active","operationalStatDate":"-0001-11-30 00:00:00","numberOfSubscribers":0}
      ]',
      code: 200
    )
    @api.http_client.http_adapter.response = response

    result = @api.get_operators
    
    refute_nil result
    refute_empty result
  end

  def test_get_operators_with_invalid_username_and_password_raises_CLX_exception
    @api.set_auth('wrong_username', 'wrong_password')
    response = OpenStruct.new(
      body: '{}',
      code: 401
    )
    @api.http_client.http_adapter.response = response

    assert_raises CLX::CLXAPIException do
      result = @api.get_operators
    end
  end

  #Get operator by id test
  def test_get_operator_by_id_returns_single_operator
    response = OpenStruct.new(
      body: '{"id":1,"name":"Foo","network":"Foonetwork","uniqueName":"Foo uniquq","isoCountryCode":"8","operationalState":"active","operationalStatDate":"-0001-11-30 00:00:00","numberOfSubscribers":0}',
      code: 200
    )
    @api.http_client.http_adapter.response = response

    operator = @api.get_operator_by_id(1)

    assert_equal operator.id, 1
  end

  def test_get_operator_by_id_with_non_existing_id_raises_CLX_exception_with_status_code_404
    response = OpenStruct.new(
      body: '{"error":{"message": "No operator with id: 9999", "code": 3001}}',
      code: 404
    )
    @api.http_client.http_adapter.response = response

    err = assert_raises CLX::CLXAPIException do
      operator = @api.get_operator_by_id(9999)
    end
  end

  def test_get_operator_by_id_with_non_integer_parameter_raises_CLX_exception
    assert_raises CLX::CLXException do
      operator = @api.get_operator_by_id('asd')
    end
  end

  def test_get_operator_by_id_with_invalid_username_and_password_raises_CLX_exception
    @api.set_auth('wrong_username', 'wrong_password')
    response = OpenStruct.new(
      body: '{}',
      code: 401
    )
    @api.http_client.http_adapter.response = response
    assert_raises CLX::CLXAPIException do
      result = @api.get_operator_by_id(1)
    end
  end

end