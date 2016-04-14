# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vela/version'

Gem::Specification.new do |spec|
  spec.name          = "vela"
  spec.version       = Vela::VERSION
  spec.authors       = ["tokhi"]
  spec.email         = ["shafi.tokhi@gmail.com"]

  spec.summary       = %q{Vela is a simple light gem which clone a table records from mysql to postgresql and vice versa.}
  spec.description   = %q{Vela is a simple light gem which clone a table records from mysql to postgresql and vice versa. This gem is helpful when you want to have the same table records in a different db.

However this gem is also enable to clone the records of a table to another table even if the destination table has a different name and columns name.}
  spec.homepage      = "https://github.com/tokhi/vela"
  spec.license       = "MIT"

 
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
