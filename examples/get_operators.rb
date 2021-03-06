begin
  clx = CLX::API.new('username', 'password')
  operators = clx.get_operators
  
  operators.each do |operator|
    puts operator.id
    puts operator.name
    puts operator.network
    puts operator.uniqueName
    puts operator.isoCountryCode
    puts operator.operationalState
    puts operator.operationalStatDate
    puts operator.numberOfSubscribers
  end
  
rescue CLX::CLXAPIException => e
  puts e.clx_error_message
  puts e.clx_error_code
rescue CLX::CLXException => e
  puts e.message
rescue
  puts 'other error'
end