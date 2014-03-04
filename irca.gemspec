# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name          = "irca"
  spec.version       = IRCA_VERSION
  spec.authors       = ["Adam Hamsik"]
  spec.email         = ["adam.hamsik@innovatrics.com"]
  spec.summary       = %q{Innovatrics Remote Connection Agent}
  spec.description   = %q{Innovatrics Remote Connection Agent}
  spec.homepage      = ""
  spec.license       = "GPLv2"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
