module CLX

  # CLX Exception Class for API request errors
  class CLXAPIException < Exception

    # @!attribute [r]
    attr_reader :clx_error_code

    # @!attribute [r]
    attr_reader :clx_error_message

    # Initialize CLX Exception
    # @param [Integer] http_status_code
    # @param [Mixed] clx_respone_error
    # @example
    #   response = http_adapter.get('operator/99999999') #results in error from api
    #   raise CLXException(response.code, response.body), ""
    def initialize(clx_error_message, clx_error_code = nil)
      @clx_error_message = clx_error_message
      @clx_error_code = clx_error_code
    end

  end

end