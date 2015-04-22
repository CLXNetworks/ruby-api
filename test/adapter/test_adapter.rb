require 'uri'

module CLX
  
  #HTTP adapter class for testing the adapter class
  class TestAdapter

    # @!attribute [r]
    attr_reader :username
    
    # @!attribute [r]
    attr_reader :password

    # Set credentials for basic auth
    def setAuth(username, password)
      @username = username
      @password = password
    end

    # GET-request
    def get(url, params)
      return execute('get', url, params)
    end

    # POST-request
    def post(url, data, params = nil)
      #return execute('post', url, data, params)
      raise NotImplementedError
    end

    # PUT-request
    def put(url, data, params = nil)
      raise NotImplementedError
    end

    # DELETE-request
    def delete(url, data, params = nil)
      raise NotImplementedError
    end

    

  end

end