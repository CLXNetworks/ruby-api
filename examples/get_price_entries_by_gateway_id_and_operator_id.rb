begin
  clx = CLX::API.new('username', 'password')
  price = clx.get_price_entries_by_gateway_id_and_operator_id(6, 1)

  puts price.price
  puts price.gateway
  puts price.operator
  puts price.expireDate

rescue CLX::CLXAPIException => e
  puts e.clx_error_message
  puts e.clx_error_code
rescue CLX::CLXException => e
  puts e.message
rescue
  puts 'other error'
end