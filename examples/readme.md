#Examples

## Get operators
```ruby
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
```


## Get operator by id
```ruby
begin
  clx = CLX::API.new('username', 'password')
  operator = clx.get_operator_by_id(6)

  puts operator.id
  puts operator.name
  puts operator.network
  puts operator.uniqueName
  puts operator.isoCountryCode
  puts operator.operationalState
  puts operator.operationalStatDate
  puts operator.numberOfSubscribers

rescue CLX::CLXAPIException => e
  puts e.clx_error_message
  puts e.clx_error_code
rescue CLX::CLXException => e
  puts e.message
rescue
  puts 'other error'
end
```


## Get gateways
```ruby
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
```


## Get gateway by id
```ruby
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
```


## Get price entires by gateway id
```ruby
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
```


## Get price entry by gateway id and operator id
```ruby
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
```


## Get price entry by gateway id, operator id and date
```ruby
begin
  clx = CLX::API.new('username', 'password')
  date = DateTime.new(2015, 5, 25)
  price = clx.get_price_entries_by_gateway_id_and_operator_id_and_date(6, 1, date)

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
```