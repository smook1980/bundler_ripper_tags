# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bundler_ripper_tags/version'

Gem::Specification.new do |spec|
  spec.name          = 'bundler_ripper_tags'
  spec.version       = BundlerRipperTags::VERSION
  spec.authors       = ['Shane Mook']
  spec.email         = ['smook@ncsasports.org']

  spec.summary       = 'Generate TAGS for a bundler project and dependencies.'
  spec.description   = 'Generate TAGS for a bundler project and dependencies.  Currently only works for emacs.'
  spec.homepage      = 'https://github.com/smook1980/bundler_ripper_tags'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'bundler', '~> 1.10'
  spec.add_runtime_dependency 'ripper-tags', '~> 0.3.2'

  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-doc'
end
