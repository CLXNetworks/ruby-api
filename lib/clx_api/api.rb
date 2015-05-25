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
    #   list of operators as hash.
    # @example
    #   clx_api = CLX::API.new 'my_username', 'my_password'
    #   operators = clx_api.get_operators
    def get_operators
      url = CLX.paths[:operator]
      @http_client.get(url)
    end

    # Get one operator based on it's operator id
    # @param [Integer] operator_id Operator ID
    # @return [hash] operator
    #   One operator as hash.
    # @example
    #   clx_api = CLX::API.new 'my_username', 'my_password'
    #   operator = clx_api.get_operator(1)
    def get_operator_by_id(operator_id)
      valid_id?(operator_id)
      url = CLX.paths[:operator] + '/' + operator_id.to_s
      @http_client.get(url)
    end

    # Get all gateways
    # @return [hash] gateways
    #   list of gateways as hash.
    def get_gateways
      url = CLX.paths[:gateway]
      @http_client.get(url)
    end
    
    # Get one gateway based on it's gateway id
    # @param [Integer] gateway_id Gateway ID
    # @return [hash] gateway
    #   One operators as hash.
    def get_gateway_by_id(gateway_id)
      valid_id?(gateway_id)
      url = CLX.paths[:gateway] + '/' + gateway_id.to_s
      @http_client.get(url)
    end
    
    # Get price entires based on gateway id
    # @param [Integer] gateway_id Gateway ID
    # @return [hash] price_entires
    #   list of price entries as hash.
    def get_price_entires_by_gateway_id(gateway_id)
      valid_id?(gateway_id)
      url = CLX.paths[:gateway] + '/' + gateway_id.to_s + '/price'
      @http_client.get(url)
    end

    # Get price entiry based on gateway id and operator id
    # @param [Integer] gateway_id Gateway ID
    # @param [Integer] operator_id Operator ID
    # @return [hash] price_entry
    #   one price entry as hash.
    def get_price_entries_by_gateway_id_and_operator_id(gateway_id, operator_id)
      valid_id?(gateway_id)
      valid_id?(operator_id)
      url = CLX.paths[:gateway] + '/' + gateway_id.to_s + '/price/' + operator_id.to_s
      @http_client.get(url)
    end

    # Get price entiry based on gateway id, operator id and a date
    # @param [Integer] gateway_id Gateway ID
    # @param [Integer] operator_id Operator ID
    # @param [DateTime] date DateTime
    # @return [hash] price_entry
    #   one price entry as hash.
    def get_price_entries_by_gateway_id_and_operator_id_and_date(gateway_id, operator_id, date)
      valid_id?(gateway_id)
      valid_id?(operator_id)
      valid_date?(date)
      date_query = "?date=#{date.year}-#{date.month}-#{date.day}"
      url = CLX.paths[:gateway] + '/' + gateway_id.to_s + '/price/' + operator_id.to_s + '/' + date_query
      @http_client.get(url)
    end

    private

      # Validates that in is of type integer and is grater than zero
      def valid_id?(id)
        raise CLXException, 'Id must be integer' unless id.is_a? Integer
        raise CLXException, 'Id must be greater than zero' unless id > 0
      end

      #Validates that date is of type DateTime
      def valid_date?(date)
        raise CLXException, 'Date must be of type DateTime' unless date.is_a? DateTime
      end

  end

end