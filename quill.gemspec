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

  gem.add_dependency 'activesupport', ['>= 3.0.0']
  gem.add_dependency 'activerecord', ['>= 1.10.0']
  gem.add_dependency 'actionpack', ['>= 3.0.0']
  gem.add_dependency 'rails', ['>= 3.1.0']

  gem.add_development_dependency 'bundler', ['>= 1.0.0']
  gem.add_development_dependency 'rake', ['>= 0']
  gem.add_development_dependency 'sqlite3', ['>= 0']
  gem.add_development_dependency 'rspec', ['>= 0']
  gem.add_development_dependency 'capybara', ['>= 1.0']
  gem.add_development_dependency 'database_cleaner', ['>= 0']
  gem.add_development_dependency 'rdoc', ['>= 0']
  gem.add_development_dependency 'rdoc', ['>= 0']
  gem.add_development_dependency 'mocha', ['>= 0.12.6']
end
