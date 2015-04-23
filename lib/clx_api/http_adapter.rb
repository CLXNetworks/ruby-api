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
    # @return [HTTP::Response]
    def get(url)
      return execute('get', url)
    end

    # POST-request
    #   (Not implemented)
    # @param [String] url
    #   Full URL to API resource
    # @param [Hash] data
    #   POST-data
    # @return [HTTP::Response]
    def post(url, data)
      #return execute('post', url, data)
      raise NotImplementedError
    end

    # PUT-request
    #   (Not implemented)
    # @param [String] url
    #   Full URL to API resource
    # @param [Hash] data
    #   PUT-data
    # @return [HTTP::Response]
    def put(url, data)
      #return execute('put', url, data)
      raise NotImplementedError
    end

    # DELETE-request
    #   (Not implemented)
    # @param [String] url
    #   Full URL to API resource
    # @return [HTTP::Response]
    def delete(url)
      #return execute('delete', url)
      raise NotImplementedError
    end

    private

      # Execute request
      # @param [String] method
      # @param [String] url
      #   Full API-path
      # @data [Hash] data
      # @return [HTTP::Response] result
      # @raise [CLXException] if request fails to generate reponse
      def execute(method, url, data = nil)
        uri = URI(url) if valid_url?(url)
        request = create_request(method, uri, data)
        request.basic_auth(@username, @password)
        http = create_http(uri);

        return http.request(request)
      end

      # Create Request object by method and uri
      # @param [String] method
      #   HTTP
      # @return [Mixed] request
      #   Net::HTTP::Get, Net::HTTP::Post, Net::HTTP::Put, Net::HTTP::Delete
      # @example
      #   request = create_request("GET", 'http://some.url')
      # @raise [CLXException] If an invalid type of request was made
      def create_request(method, uri, data)
        method = method.upcase
        if(method == 'GET')
          return Net::HTTP::Get.new(uri)
        elsif(method == 'POST')
          request = Net::HTTP::Post.new(uri)
          request.body = data.to_json
          return request
        elsif(method == 'PUT')
          request = Net::HTTP::Put.new(uri)
          request.body = data.to_json
          return request
        elsif(method == 'DELETE')
          return Net::HTTP::Delete.new(uri)
        else
          raise CLXException, 'Unknown HTTP method'
        end
      end

      # Creates a Net:HTTP instance with ssl activated with URI-object
      # @param [String] url
      # @return [Net::HTTP] http
      def create_http(url)
        uri = URI(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        return http
      end
      
      # Encodes passed mixed variable to a URL-encoded query string
      # @param [Mixed] params
      #   String, Hash or Array
      # @return [String] query_string
      # @example
      #   date = 'date=2014-01-01'
      #   encoded_date = url_encode(date)
      # @example
      #   param_hash = {my_date: '2014-01-01', my_string: 'a string', my_int: 1}
      #   encoded_params = url_encode(param_hash)
      def url_encode(params)
        return URI.encode(params) if params.instance_of? String

        if params.instance_of?(Hash) || params.instance_of?(Array)
          return '' if params.size == 0

          ret = ''
          params.each do | key, value |
            ret += format('&%s=%s', key, value)
          end

          return ret[1..-1]
        end
        
        return ''
      end

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