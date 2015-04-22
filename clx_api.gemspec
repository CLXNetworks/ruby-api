# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'clx_api/version'

Gem::Specification.new do |spec|
  spec.name          = "clx_api"
  spec.version       = CLX::VERSION
  spec.authors       = ["Andreas Fridlund"]
  spec.email         = ["afrxx09@student.lnu.se"]
  spec.summary       = %q{CLX Networks API Gem.}
  spec.description   = %q{Ruby Gem for CLX Networks API.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.5.1"
  spec.add_development_dependency "yard", "~> 0.8.7.6"
end