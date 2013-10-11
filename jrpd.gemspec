# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jrpd/version'

Gem::Specification.new do |spec|
  spec.name          = "jrpd"
  spec.version       = Jrpd::VERSION
  spec.authors       = ["Simon Break", "Matthew Simpson"]
  spec.email         = ["simonbreak@gmail.com"]
  spec.summary       = "A simple JRuby wrapper for the libpd Java API"
  spec.homepage      = "https://github.com/originalproject/jrpd"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
