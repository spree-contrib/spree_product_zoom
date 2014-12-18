# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_product_zoom'
  s.version     = '2.2'
  s.summary     = 'Add product image zoom functionality via a lightbox'
  s.required_ruby_version = '>= 1.8.7'

  s.author    = 'John Dyer'
  s.email     = 'jdyer@spreecommerce.com'
  s.homepage  = 'http://www.spreecommerce.com'

  s.files       = `git ls-files`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 2.4' 
  s.add_dependency 'spree_frontend', '~> 2.4'

  s.add_development_dependency 'capybara', '2.4.1'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.4.0'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.9'
  s.add_development_dependency 'sass-rails', '~> 4.0.3'
  s.add_development_dependency 'coffee-rails', '4.0.1'  
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'sqlite3'
end
