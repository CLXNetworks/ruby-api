module CLX

  # Library class for CLX Networks REST API
  class API

    # @!attribute [r]
    # Mostly for testing
    attr_accessor :http_client
    
    # Initialize a new API client
    # @param [String] username
    # @param [String] password
    # @param [HTTPClient] http_client
    #   Used for testing
    # @return [CLX::API]
    # @example
    #   CLX::API.new 'my_username', 'my_password'
    def initialize(username, password, http_adapter = nil)
      http_adapter = http_adapter.nil? ? HTTPAdapter.new : http_adapter
      http_adapter.setAuth(username, password)

      @http_client = HTTPClient.new(CLX::base_url, http_adapter)
    end

  end

end