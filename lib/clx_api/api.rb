module CLX

  # Library class for CLX Networks REST API
  class API

    # @!attribute [r]
    # Mostly for testing
    attr_accessor :http_client
    
    # Initialize a new API client
    # @param [String] username
    # @param [String] password
    # @param [HTTPAdapter] http_adapter
    #   Used for testing
    # @return [CLX::API]
    # @example
    #   CLX::API.new 'my_username', 'my_password'
    def initialize(username, password, http_adapter = nil)
      http_adapter = http_adapter.nil? ? HTTPAdapter.new : http_adapter
      http_adapter.set_auth(username, password)

      @http_client = HTTPClient.new(CLX::base_url, http_adapter)
    end

    # Enables change of credentials after initialization
    # @param [String] username
    # @param [String] password
    def set_auth(username, password)
      @http_client.http_adapter.set_auth(username, password)
    end

    # Enables change of base URL after initialization
    # @param [String] url
    def set_base_url(url)
      @http_client.base_url = url
    end

    # Get all operators from the API
    # @return [hash] operators
    #   list of operators in hash.
    # @example
    #   clx_api = CLX::API.new 'my_username', 'my_password'
    #   operators = clx_api.get_operators
    def get_operators
      url = CLX.paths[:operator]
      @http_client.get(url)
    end

    # Get one operator based on it's operator id
    # @param [Integer] id Operator ID
    # @return [hash] operator
    #   One operator hash.
    # @example
    #   clx_api = CLX::API.new 'my_username', 'my_password'
    #   operator = clx_api.get_operator(1)
    def get_operator_by_id(id)
      raise CLXException, 'Operator id must be integer' unless id.is_a? Integer
      raise CLXException, 'Operator id must be greater than zero' unless id > 0
      
      url = CLX.paths[:operator] + '/' + id.to_s
      @http_client.get(url)
    end

  end

end