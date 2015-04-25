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
    def set_auth(username, password)
      raise CLXException, 'Username must be a string' unless username.is_a? String
      raise CLXException, 'Password must be a string' unless password.is_a? String
      raise CLXException, 'Username can not be an empty string' unless username.length > 0
      raise CLXException, 'Password can not be an empty string' unless password.length > 0
      
      @username = username
      @password = password
    end

    # GET-request
    # @param [URI] uri
    #   Ruby URI object with full API URL
    # @return [HTTP::Response]
    def get(uri)
      return execute('get', uri)
    end

    # POST-request
    #   (Not implemented)
    # @param [URI] uri
    #   Ruby URI object with full API URL
    # @param [Hash] data
    #   POST-data
    # @return [HTTP::Response]
    def post(uri, data)
      return execute('post', uri, data)
    end

    # PUT-request
    #   (Not implemented)
    # @param [URI] uri
    #   Ruby URI object with full API URL
    # @param [Hash] data
    #   PUT-data
    # @return [HTTP::Response]
    def put(uri, data)
      return execute('put', uri, data)
    end

    # DELETE-request
    #   (Not implemented)
    # @param [URI] uri
    #   Ruby URI object with full API URL
    # @return [HTTP::Response]
    def delete(uri)
      return execute('delete', uri)
    end

    private

      # Execute request
      # @param [String] method
      # @param [String] uri
      #   Full API-path
      # @param [Hash] data
      # @return [HTTP::Response] result
      # @raise [CLXException] if he request fails
      def execute(method, uri, data = nil)
        raise CLXException, 'uri must be instance of URI' unless uri.instance_of?(URI::HTTPS) || uri.instance_of?(URI::HTTP)
        request = create_request(method, uri, data)
        request.basic_auth(@username, @password)
        http = create_http(uri);

        return http.request(request)
      end

      # Create Request object by method and uri
      # @param [String] method
      #   HTTP
      # @param [URI] uri
      # @param [Hash] data
      # @return [Mixed] request
      #   Net::HTTP::Get, Net::HTTP::Post, Net::HTTP::Put, Net::HTTP::Delete
      # @example
      #   request = create_request("GET", 'http://some.url')
      # @raise [CLXException] If an invalid HTTP-method was passed
      def create_request(method, uri, data = nil)
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
      # @param [URI] uri
      # @return [Net::HTTP] http
      def create_http(uri)
        http = Net::HTTP.new(uri.host, uri.port)
        if uri.instance_of? URI::HTTPS
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
        return http
      end
      
  end

end