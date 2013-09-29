source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '3.2.13'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier',     '>= 1.0.3'
  gem 'haml_coffee_assets'
  gem 'execjs'
end

gem 'jquery-rails'
gem 'devise'
gem 'figaro'
gem 'haml-rails'
gem 'pg'
gem 'stripe'
gem 'unicorn'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', platforms: [ :mri_19, :rbx ]
  gem 'html2haml'
  gem 'meta_request'
  gem 'pry-rails'
  gem 'quiet_assets'
end

group :development, :test do
  gem 'fabrication'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end

group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'launchy'
end
