# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rx_nav/version'

Gem::Specification.new do |spec|
  spec.name          = 'rx_nav'
  spec.version       = RxNav::VERSION
  spec.authors       = ['Jonathan Bender']
  spec.email         = ['jlbender@gmail.com']
  spec.description   = 'Ruby wrappers for the RxNav RESTful APIs'
  spec.summary       = 'Ruby-based way of interacting with the RxNav APIs (http://rxnav.nlm.nih.gov/APIsOverview.html)'
  spec.homepage      = 'https://github.com/jbender/rx_nav_ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'nori'
  spec.add_dependency 'nokogiri'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
