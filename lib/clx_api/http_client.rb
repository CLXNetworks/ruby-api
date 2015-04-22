module CLX
  
  #HTTP Client class for making RESTful HTTP-requests
  class HTTPClient

    # @!attribute [rw]
    attr_accessor :base_url

    # @!attribute [rw]
    attr_accessor :http_adapter

    # Initializer
    # @param [String] base_url
    def initialize(base_url, http_adapter)
      @base_url = base_url
      @http_adapter = http_adapter
    end

  end

end