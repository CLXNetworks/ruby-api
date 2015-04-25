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

    # Make a GET-request to specified API-path
    # @param [String] url
    #   API-path
    # @return [hash] result
    def get(url)
      uri = get_full_url(url)
      response = @http_adapter.get(uri)
      return parseResponse(response)
    end

    # Make a POST-request to specified API-path
    #   (Not implemented)
    # @param [String] url
    #   API-path
    # @param [Hash] data
    #   POST data
    def post(url, data = nil)
      uri = get_full_url(url)
      response = @http_adapter.post(uri, data)
      return parseResponse(response)
    end

    # Make a PUT-request to specified API-path
    #   (Not implemented)
    # @param [String] url
    #   API-path
    # @param [Hash] data
    #   PUT-data
    def put(url, data = nil)
      uri = get_full_url(url)
      response = @http_adapter.put(uri, data)
      return parseResponse(response)
    end

    # Make a DELETE-request to specified API-path
    #   (Not implemented)
    # @param [String] url
    #   API-path
    def delete(url)
      uri = get_full_url(url)
      response = @http_adapter.delete(uri)
      return parseResponse(response)
    end

    private
      
      # Build the full API request URL
      # @param [string] url
      #   API-path
      # @return [Mixed] uri
      #   URI::HTTP or URI::HTTPS
      # @example
      #   uri = get_full_url('/gateway/1/operator/')
      def get_full_url(url)
        full_url = @base_url + url
        return URI(URI.encode(full_url))
      end

      # Parse response from a request and return body content as JSON
      # @param [NET::HTTP::response] response
      # @return [JSON] json
      def parseResponse(response)

        begin
          result = JSON.parse(response.body, object_class: OpenStruct)
        rescue
          raise CLXException, 'Unable to parse JSON response'
        end

        if(response.code > 399)
          error_message = (result.error && result.error.message) ? result.error.message : 'No error message available'
          code = (result.error && result.error.code) ? result.error.code : 'No error code available'
          raise CLXAPIException.new(error_message, code), '400: Bad request' if response.code == 400
          raise CLXAPIException.new(error_message, code), '401: Unauthorized' if response.code == 401
          raise CLXAPIException.new(error_message, code), '403: Forbidden' if response.code == 403
          raise CLXAPIException.new(error_message, code), '404: Not Found' if response.code == 404
          raise CLXAPIException.new(error_message, code), 'Unknown error'
        end

        return result
      end

      #################################
      # Currently unused helper methods
      #################################

      # # Method for validating URL's
      # # @param [String] url
      # # @return [Boolean]
      # # @raise [CLXException]
      # def valid_url?(url)
      #   raise CLXException, 'url can not be an empty string' if url.to_s.strip.length == 0
      #   # Seems to accept any string as a valid url, might need some work
      #   !!URI.parse(url)
      #   rescue URI::InvalidURIError
      #     raise CLXException, format('URL: "%s" is not a valid url', url)
      # end

      # # Encodes passed mixed variable to a URL-encoded query string
      # # @param [Mixed] params
      # #   String, Hash or Array
      # # @return [String] query_string
      # # @example
      # #   date = 'date=2014-01-01'
      # #   encoded_date = url_encode(date)
      # # @example
      # #   param_hash = {my_date: '2014-01-01', my_string: 'a string', my_int: 1}
      # #   encoded_params = url_encode(param_hash)
      # def url_encode(params)
      #   return URI.encode(params) if params.instance_of? String

      #   if params.instance_of?(Hash) || params.instance_of?(Array)
      #     return '' if params.size == 0

      #     ret = ''
      #     params.each do | key, value |
      #       ret += format('&%s=%s', key, value)
      #     end

      #     return ret[1..-1]
      #   end
        
      #   return ''
      # end

      # # Tries to validate that parameter argument is in the correct format: String, Array or Hash
      # # @param [Mixed] params
      # # @return [Boolean]
      # # @raise [CLXException]
      # def valid_params?(params)
      #   if params != nil
      #     if params.is_a?(String) || params.is_a?(Hash) || params.is_a?(Array)
      #       return true
      #     else
      #       raise CLXException, 'params must be String, Hash or Array'
      #     end
      #   end
      # end

  end

end