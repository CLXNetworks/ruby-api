require 'clx_api/version'
require 'clx_api/api'
require 'clx_api/exceptions/clx_exception'
require 'clx_api/exceptions/clx_api_exception'
require 'clx_api/http_client'
require 'clx_api/http_adapter'

# Main namespace
module CLX

  # Module instance
  class << self

    # @!attribute [r]
    attr_reader :base_url
    
    # @!attribute [r]
    attr_reader :paths
    
    # REST server
    def base_url
      @base_url ||= 'https://clx-aws.clxnetworks.com/api'
    end
    
    # API paths hash
    def paths
      @paths ||= {
        operator: '/operator/',
        gateway: '/gateway/'
      }
    end

  end

end
