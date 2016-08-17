# coding: utf-8
require File.expand_path('../lib/aker/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "aker"
  spec.version       = Aker::VERSION
  spec.authors       = ["Jefferson Leard"]
  spec.email         = ["jtleard@gmail.com"]
  spec.summary       = %q{Aker}
  spec.description   = %q{Aker}
  spec.homepage      = "https://github.com/bitpuncher/aker"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'activesupport', '~> 4.2', '>= 4.2.5'
  spec.add_runtime_dependency 'activemodel', '~> 4.2', '>= 4.2.5'
  spec.add_runtime_dependency 'faraday', '~> 0.9'
  spec.add_runtime_dependency 'hashie', '~> 3.4'
  spec.add_runtime_dependency 'typhoeus', '~> 1.0'
  spec.add_runtime_dependency 'faraday_middleware', '~> 0.10'
end
