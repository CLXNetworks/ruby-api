begin
  clx = CLX::API.new('username', 'password')
  gateway = clx.get_gateway_by_id(6)

  puts gateway.id
  puts gateway.name
  puts gateway.type

rescue CLX::CLXAPIException => e
  puts e.clx_error_message
  puts e.clx_error_code
rescue CLX::CLXException => e
  puts e.message
rescue
  puts 'other error'
end