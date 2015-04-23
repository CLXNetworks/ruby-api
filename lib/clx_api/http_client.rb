module CLX
  
  #HTTP Client class for making RESTful HTTP-requests
  class HTTPClient

    # Gives access to base_url so this can be modified
    # @!attribute [rw]
    attr_accessor :base_url

    # Gives access to the adapter so Auth credentials can be monipulated
    # @!attribute [rw]
    attr_accessor :http_adapter

    # Initializer
    # @param [String] base_url
    # @param [HTTPAdapter] http_adapter
    def initialize(base_url, http_adapter)
      @base_url = base_url
      @http_adapter = http_adapter
    end

  end

end