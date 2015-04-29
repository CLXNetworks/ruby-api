module CLX

  # CLX Exception Class for API request errors
  class CLXAPIException < Exception

    # @!attribute [r]
    attr_reader :clx_error_code

    # @!attribute [r]
    attr_reader :clx_error_message

    # Initialize CLX Exception
    # @param [String] clx_error_message
    # @param [Integer] clx_error_code
    # @example
    #   response = http_adapter.get('operator/99999999') #results in error from api
    #   raise CLXException(response.code, response.body), ""
    def initialize(clx_error_message = nil, clx_error_code = nil)
      @clx_error_message = clx_error_message
      @clx_error_code = clx_error_code
    end

  end

end