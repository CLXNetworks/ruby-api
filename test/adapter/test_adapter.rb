require 'uri'

module CLX
  
  #HTTP Adapter class for making RESTful HTTP-requests
  class TestAdapter

    # Contains the username used for Basic Auth requests
    # @!attribute [r]
    attr_reader :username
    
    # Contains the password used for Basic Auth requests
    # @!attribute [r]
    attr_reader :password

    # Set credentials for basic auth
    def setAuth(username, password)
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
        path = uri.path
        response = getTestReponse(path);

        return response
      end

      # Get fake response object from url
      def getTestReponse(path)
        return getFakeOperators if path == '/operator'
        return getFakeOperator if path == '/operator/1'
        return getOperatorNotFound if path == '/operator/9999'
      end

      # fake operator list
      def getFakeOperators
        body = '[
          {"id":1,"name":"Foo","network":"Foonetwork","uniqueName":"Foo uniquq","isoCountryCode":"8","operationalState":"active","operationalStatDate":"-0001-11-30 00:00:00","numberOfSubscribers":0},
          {"id":1058,"name":"Bar mobile","network":"Bar Mobile","uniqueName":"Foo Mobile-unique","isoCountryCode":"8","operationalState":"active","operationalStatDate":"-0001-11-30 00:00:00","numberOfSubscribers":0}
        ]'
        code = 200
        return create_response(body, code)
      end

      # fake operator
      def getFakeOperator
        body = '{"id":1,"name":"Foo","network":"Foonetwork","uniqueName":"Foo uniquq","isoCountryCode":"8","operationalState":"active","operationalStatDate":"-0001-11-30 00:00:00","numberOfSubscribers":0}';
        code = 200
        return create_response(body, code)
      end

      # fake operator by id with invalid id
      def getOperatorNotFound
        body = '{"error":{"message": "No operator with id: 9999", "code": 3001}}'
        code = 404
        return create_response(body, code)
      end

      def create_response(body, code)
        response = {
          body: body,
          code: code
        }
        return OpenStruct.new(response)
      end

  end

end