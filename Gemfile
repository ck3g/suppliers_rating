source 'https://rubygems.org'

gem 'rails', '3.2.8'
gem "rake", "10.0.2"

gem 'pg'
gem "devise"
gem "cancan"
gem "haml-rails"
gem 'jquery-rails'
gem "has_scope"
gem 'meta-tags', require: "meta_tags"
gem 'anjlab-bootstrap-rails', ">= 2.2", require: 'bootstrap-rails'
gem 'simple_form'
gem "faker", "~> 1.0.1"
gem "russian"
gem "kaminari", "~> 0.14.1"
gem "rails3-jquery-autocomplete"
gem "squeel", "~> 1.0.13"
gem "thin"
gem 'sass-rails',   '~> 3.2.3'

group :assets do
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier',     '>= 1.0.3'
  gem "therubyracer"
end

group :development do
  gem "capistrano",         require: false
  gem 'capistrano-recipes', require: false
  gem 'capistrano_colors',  require: false
  gem "erb2haml"
  gem "rails_best_practices"
  gem "pry-rails"
  gem "meta_request", "0.2.0"
end

group :development, :test do
  gem 'rspec-rails',        '~> 2.11.0'
  gem 'factory_girl_rails', '~> 3.5.0'
  gem 'guard-rspec',        '~> 1.2.0'
end

group :test do
  gem "launchy"
  gem 'spork',              '>= 0.9.0.rc9'
  gem 'guard-spork',        '~> 1.1.0'
  gem 'guard-bundler',      '~> 1.0.0'
  gem "capybara",           "~> 1.1.2"
  gem "database_cleaner"
  gem "shoulda"
  gem "email_spec"

  gem 'rb-fsevent', '>= 0.4.3', require: false
  gem 'growl',      '~> 1.0.3', require: false
  gem 'rb-inotify', '>= 0.8.6', require: false
  gem 'libnotify',  '~> 0.5.7', require: false
end

group :production do
  gem "exception_notification"
end
