# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'beret/version'

Gem::Specification.new do |spec|
  spec.name          = "beret"
  spec.version       = Beret::VERSION
  spec.authors       = ["Lawson Kurtz (Viget)"]
  spec.email         = ["lawson.kurtz@viget.com"]

  spec.summary       = "Utility for consuming and manipulating Colonel Kurtz data"
  spec.description   = "Easily work with Colonel Kurtz-generated JSON data in your Ruby application"
  spec.homepage      = "https://github.com/vigetlabs/beret"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
