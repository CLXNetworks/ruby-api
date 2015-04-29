require 'uri'
require 'json'

module CLX
  
  #HTTP Adapter class for making RESTful HTTP-requests
  class TestAdapter

    # @!attribute [r]
    attr_accessor :response

    # @!attribute [r]
    attr_accessor :request_url

    # @!attribute [r]
    attr_accessor :request_method
    
    # @!attribute [r]
    attr_reader :username
    
    # @!attribute [r]
    attr_reader :password

    # Set credentials for basic auth
    def set_auth(username, password)
      raise CLXException, 'Username must be a string' unless username.is_a? String
      raise CLXException, 'Password must be a string' unless password.is_a? String
      raise CLXException, 'Username can not be an empty string' unless username.length > 0
      raise CLXException, 'Password can not be an empty string' unless password.length > 0
      
      @username = username
      @password = password
    end

    # GET-request
    def get(uri)
      return execute('get', uri)
    end

    # POST-request
    def post(uri, data)
      return execute('post', uri, data)
    end

    # PUT-request
    def put(uri, data)
      return execute('put', uri, data)
    end

    # DELETE-request
    def delete(uri)
      return execute('delete', uri)
    end

    private

      # Execute request
      def execute(method, uri, data = nil)

        @request_url = uri.to_s
        @request_method = method.upcase
        return @response
      end

  end

end