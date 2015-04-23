require 'uri'

module CLX
  
  #HTTP Adapter class for making RESTful HTTP-requests
  class HTTPAdapter

    # Contains the username used for Basic Auth requests
    # @!attribute [r]
    attr_reader :username
    
    # Contains the password used for Basic Auth requests
    # @!attribute [r]
    attr_reader :password

    # Set credentials for basic auth
    # @param [String] username
    # @param [String] password
    def setAuth(username, password)
      raise CLXException, 'Username must be a string' unless username.is_a? String
      raise CLXException, 'Password must be a string' unless password.is_a? String
      raise CLXException, 'Username can not be an empty string' unless username.length > 0
      raise CLXException, 'Password can not be an empty string' unless password.length > 0
      
      @username = username
      @password = password
    end

    # GET-request
    # @param [String] url
    #   Full URL to API resource
    # @param [Mixed] params
    #   String, Hash or Array
    # @return [HTTP::Response]
    def get(url, params = nil)
      valid_url?(url)
      valid_params?(params)
      #return execute('get', url, params)
      raise NotImplementedError
    end

    # POST-request
    #   (Not implemented)
    # @param [String] url
    #   Full URL to API resource
    # @param [Hash] data
    #   POST-data
    # @param [Mixed] params
    #   String, Hash or Array
    # @return [HTTP::Response]
    def post(url, data, params = nil)
      #return execute('post', url, data, params)
      raise NotImplementedError
    end

    # PUT-request
    #   (Not implemented)
    # @param [String] url
    #   Full URL to API resource
    # @param [Hash] data
    #   PUT-data
    # @param [Mixed] params
    #   String, Hash or Array
    # @return [HTTP::Response]
    def put(url, data, params = nil)
      #return execute('put', url, data, params)
      raise NotImplementedError
    end

    # DELETE-request
    #   (Not implemented)
    # @param [String] url
    #   Full URL to API resource
    # @param [Mixed] params
    #   String, Hash or Array
    # @return [HTTP::Response]
    def delete(url, params = nil)
      #return execute('delete', url, data?, params?)
      raise NotImplementedError
    end



    private

      # Method for validating URL's
      # @param [String] url
      # @return [Boolean]
      # @raise [CLXException]
      def valid_url?(url)
        raise CLXException, 'url can not be an empty string' if url.to_s.strip.length == 0
        # Seems to accept any string as a valid url, might need some work
        !!URI.parse(url)
        rescue URI::InvalidURIError
          raise CLXException, format('URL: "%s" is not a valid url', url)
      end

      # Tries to validate that parameter argument is in the correct format: String, Array or Hash
      # @param [Mixed] params
      # @return [Boolean]
      # @raise [CLXException]
      def valid_params?(params)
        if params != nil
          if params.is_a?(String) || params.is_a?(Hash) || params.is_a?(Array)
            return true
          else
            raise CLXException, 'params must be String, Hash or Array'
          end
        end
      end

  end

end