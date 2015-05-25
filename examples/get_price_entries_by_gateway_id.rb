begin
  clx = CLX::API.new('username', 'password')
  prices = clx.get_price_entires_by_gateway_id(6)
  
  prices.each do |price|
    puts price.price
    puts price.gateway
    puts price.operator
    puts price.expireDate
  end

rescue CLX::CLXAPIException => e
  puts e.clx_error_message
  puts e.clx_error_code
rescue CLX::CLXException => e
  puts e.message
rescue
  puts 'other error'
end