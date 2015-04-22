module CLX
  
  #HTTP Adapter class for making RESTful HTTP-requests
  class HTTPAdapter

    # @!attribute [r]
    attr_reader :username
    
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
    def get(url, params = nil)
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
    def delete(url, params = nil)
      #return execute('delete', url, data?, params?)
      raise NotImplementedError
    end

  end

end