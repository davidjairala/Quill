# -*- encoding: utf-8 -*-
require File.expand_path('../lib/quill/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["David Jairala"]
  gem.email         = ["davidjairala@gmail.com"]
  gem.description   = %q{Allows fast object pagination in Rails for very large datasets.}
  gem.summary       = %q{Fast and simple object pagination for Rails.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "quill"
  gem.require_paths = ["lib"]
  gem.version       = Quill::VERSION

  gem.add_dependency 'rails',           ['~> 3.2.8']
end
