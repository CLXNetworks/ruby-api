begin
  clx = CLX::API.new('username', 'password')
  gateways = clx.get_gateways
  
  gateways.each do |gateway|
    puts gateway.id
    puts gateway.name
    puts gateway.type
  end
  
rescue CLX::CLXAPIException => e
  puts e.clx_error_message
  puts e.clx_error_code
rescue CLX::CLXException => e
  puts e.message
rescue
  puts 'other error'
end