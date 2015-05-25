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

  def test_request_with_invalid_username_and_password_raises_CLX_exception
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

  #Operator tests
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
    assert_equal(result.size, 2)
  end

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

  #Gateway tests
  def test_that_get_gateways_return_a_collection_of_gateways
    response = OpenStruct.new(
      body: '[
        {"id":1,"name":"gateway no 1","type":"Some type 1"},
        {"id":2,"name":"gateway no 2","type":"Some type 2"}
      ]',
      code: 200
    )
    @api.http_client.http_adapter.response = response

    result = @api.get_gateways
    
    refute_nil result
    refute_empty result
    assert_equal(result.size, 2)
  end

  def test_that_get_gateway_by_id_returns_single_gateway
    response = OpenStruct.new(
      body: '{"id":1,"name":"gateway no 1","type":"Some type 1"}',
      code: 200
    )
    @api.http_client.http_adapter.response = response

    gateway = @api.get_gateway_by_id(1)

    assert_equal gateway.id, 1
  end

  def test_that_get_gateway_by_by_with_id_that_does_not_exist_raises_clx_api_exception
    response = OpenStruct.new(
      body: '{"error":{"message": "No gateway with id: 9999"}}',
      code: 404
    )
    @api.http_client.http_adapter.response = response

    assert_raises CLX::CLXAPIException do
      gateway = @api.get_gateway_by_id(9999)
    end
  end

  def test_that_get_gateway_by_id_with_non_integer_id_raises_clx_exception
    assert_raises CLX::CLXException do
      gateway = @api.get_gateway_by_id('a string')
    end
  end

  def test_that_get_price_entires_by_gateway_id_return_collection_of_price_entires
    response = OpenStruct.new(
      body: '[
        {"price": 0.25,"gateway":"gateway no 1","operator":"Some operator 1"},
        {"price": 0.35,"gateway":"gateway no 1","operator":"Some operator 2"}
      ]',
      code: 200
    )
    @api.http_client.http_adapter.response = response

    result = @api.get_price_entires_by_gateway_id(1)

    refute_nil result
    refute_empty result
    assert_equal(result.size, 2)
  end

  def test_that_get_price_entires_by_gateway_id_with_id_that_does_not_exist_raises_clx_api_exception
    response = OpenStruct.new(
      body: '{"error":{"message": "No gateway with id: 9999"}}',
      code: 404
    )
    @api.http_client.http_adapter.response = response

    assert_raises CLX::CLXAPIException do
      result = @api.get_price_entires_by_gateway_id(9999)
    end
  end

  def test_that_get_price_entries_by_gateway_id_with_non_integer_id_raises_clx_exception
    assert_raises CLX::CLXException do
      gateway = @api.get_price_entires_by_gateway_id('a string')
    end
  end

  def test_that_get_price_entry_by_gateway_id_and_operator_id_returns_price_entry
    response = OpenStruct.new(
      body: '{"price": "0.25","gateway": "gateway_1","operator": "Some operator","expireDate": 0}',
      code: 200
    )
    @api.http_client.http_adapter.response = response

    gateway = @api.get_price_entries_by_gateway_id_and_operator_id(1, 1)

    assert_equal gateway.gateway, "gateway_1"
  end

  def test_that_get_price_entries_by_gateway_id_and_operator_id_with_non_integer_ids_raises_clx_exception
    assert_raises CLX::CLXException do
      gateway = @api.get_price_entries_by_gateway_id_and_operator_id('a string', 1)
    end
    assert_raises CLX::CLXException do
      gateway = @api.get_price_entries_by_gateway_id_and_operator_id(1, 'a string')
    end
    assert_raises CLX::CLXException do
      gateway = @api.get_price_entries_by_gateway_id_and_operator_id('a string', 'a string')
    end
  end

  def test_that_get_price_entry_by_gateway_id_and_operator_id_and_date_returns_price_entry
    response = OpenStruct.new(
      body: '{"price": "0.25","gateway": "gateway_1","operator": "Some operator","expireDate": 0}',
      code: 200
    )
    @api.http_client.http_adapter.response = response

    gateway = @api.get_price_entries_by_gateway_id_and_operator_id_and_date(1, 1, DateTime.now)

    assert_equal gateway.gateway, "gateway_1"
  end

  def test_that_get_price_entry_by_gateway_id_and_operator_id_and_date_with_ids_that_does_not_exist_raises_clx_api_exception
    response = OpenStruct.new(
      body: '{"error":{"message": "No gateway with id: 9999"}}',
      code: 404
    )
    @api.http_client.http_adapter.response = response

    assert_raises CLX::CLXAPIException do
      result = @api.get_price_entries_by_gateway_id_and_operator_id_and_date(9999, 1, DateTime.now)
    end

    response = OpenStruct.new(
      body: '{"error":{"message": "Trying to get current and next price: PriceLinkedList missing for operator with id: 9999 in pirce list with id: 1", "code": 1002}}',
      code: 404
    )
    @api.http_client.http_adapter.response = response

    assert_raises CLX::CLXAPIException do
      result = @api.get_price_entries_by_gateway_id_and_operator_id_and_date(1, 9999, DateTime.now)
    end
  end

  def test_that_get_price_entry_by_gateway_id_and_operator_id_and_date_with_invalid_parameters_raises_clx_exception
    assert_raises CLX::CLXException do
      gateway = @api.get_price_entries_by_gateway_id_and_operator_id_and_date('a string', 1, DateTime.now)
    end
    assert_raises CLX::CLXException do
      gateway = @api.get_price_entries_by_gateway_id_and_operator_id_and_date(1, 'a string', DateTime.now)
    end
    assert_raises CLX::CLXException do
      gateway = @api.get_price_entries_by_gateway_id_and_operator_id_and_date('a string', 'a string', DateTime.now)
    end
    assert_raises CLX::CLXException do
      gateway = @api.get_price_entries_by_gateway_id_and_operator_id_and_date(1, 1, 'should_be_datetime')
    end
  end

end