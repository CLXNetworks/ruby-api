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
    
  end

end