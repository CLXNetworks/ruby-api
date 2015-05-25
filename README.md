# ClxApi

A wrapper for easier use of CLX networks API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'clx_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install clx_api

## Usage

[See examples folder](https://github.com/CLXNetworks/ruby-api/examples)

## For Developers
### Set up environment
1. Clone or download and unzip to local folder
2. Navigate to folder in console/terminal


    $ cd [your_development_folder]/ruby_api
3. Install development dependencies


  $ bundle install
    
### Runing tests
[Minitest](https://github.com/seattlerb/minitest) is used for unit testing.

  $ bundle exec rake test

### Generate documentation
[Yard](https://github.com/lsegal/yard) generates documentation from comments in the code

  $ bundle exec yard doc
    
### Code coverage
[SimpleCov](https://github.com/colszowka/simplecov) checks test coverage automatically when tests are run

## Contributing
1. Fork it ( https://github.com/CLXNetworks/ruby-api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
