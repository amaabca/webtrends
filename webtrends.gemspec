# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'webtrends/version'

Gem::Specification.new do |spec|
  spec.name          = "webtrends"
  spec.version       = Webtrends::VERSION
  spec.authors       = ["Michael van den Beuken", "Ruben Estevez", "Jordan Babe", "Mathieu Gilbert", "Ryan Jones", "Darko Dosenovic"]
  spec.email         = ["michael.beuken@gmail.com", "ruben.a.estevez@gmail.com", "jorbabe@gmail.com", "mathieu.gilbert@ama.ab.ca", "ryan.michael.jones@gmail.com", "darko.dosenovic@ama.ab.ca"]
  spec.description   = %q{Make use of the Webtrends api to post event data for analytics purposes.}
  spec.summary       = %q{Make use of the Webtrends api to post event data for analytics purposes.}
  spec.homepage      = "https://github.com/amaabca/webtrends"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-instafail"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "coveralls"
  spec.add_dependency "rest-client"

end
