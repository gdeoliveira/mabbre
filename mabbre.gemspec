# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mabbre/version"

Gem::Specification.new do |spec|
  spec.name          = "mabbre"
  spec.version       = MAbbre::VERSION
  spec.authors       = ["Gabriel de Oliveira"]
  spec.email         = ["deoliveira.gab@gmail.com"]
  spec.summary       = "Write a short summary. Required."
  spec.description   = "Write a longer description. Optional."
  spec.homepage      = "https://github.com/gdeoliveira/mabbre"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ["lib"]

  spec.add_dependency "mtrack", "~> 1.0.2"
end
