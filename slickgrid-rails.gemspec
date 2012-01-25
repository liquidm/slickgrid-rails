# -*- encoding: utf-8 -*-
require File.expand_path('../lib/slickgrid/rails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "slickgrid-rails"
  gem.version       = SlickGrid::Rails::VERSION
  gem.authors       = ["Benedikt Böhm"]
  gem.email         = ["bb@xnull.de"]
  gem.description   = %q{SlickGrid Integration for Rails 3.x}
  gem.summary       = %q{SlickGrid Integration for Rails 3.x}
  gem.homepage      = "https://github.com/madvertise/slickgrid-rails"

  gem.add_dependency "railties", "~> 3.0"
  gem.add_dependency "coffee-rails"
  gem.add_dependency "sass-rails"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ["lib"]
end
