# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'load_runner/version'

Gem::Specification.new do |spec|
  spec.name          = "load_runner"
  spec.version       = LoadRunner::VERSION
  spec.authors       = ["Don Najd"]
  spec.email         = ["dnajd7@gmail.com"]
  spec.description   = %q{Load Runner Ruby Gem allows you to run a block of code many times in parallel, stagger execution or run it for a specific amount of time}
  spec.summary       = %q{Run a block of code many times in parallel, stagger execution or run it for a specific amount of time}
  spec.homepage      = "https://github.com/dnajd/load_runner"
  spec.license       = "BSD"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
