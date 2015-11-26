source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.2'
# Use PostgreSQL as the database for Active Record
gem 'pg'
# Use ElasticSearch for external search
gem 'elasticsearch', git: 'git://github.com/elasticsearch/elasticsearch-ruby.git'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby


gem 'rails_12factor', group: :production

# Use for users authentaction
gem 'devise'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Use jquery ui
gem 'jquery-ui-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# Used by template
gem 'uikit-sass-rails', git: 'https://github.com/8398a7/uikit-sass-rails'
# http://migre.me/roo8Q enjoy :)
gem "twitter-bootstrap-rails"
# fonts and icons
gem 'font-awesome-sass', '~> 4.4.0'

# Application/Http Server
gem 'unicorn-rails'

# gem 'nouislider-rails'
gem 'touchpunch-rails'

# Monitor application in realtime
gem 'newrelic_rpm'

# cache support gem
gem 'actionpack-action_caching'

# ominiauth support gems
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-linkedin'

# payment gateway
gem 'iugu'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  # Given scenarious and features, this gem tests the application using user stories.
  gem 'cucumber-rails', require: false
  # Clean database on test enviroment
  gem 'database_cleaner'
  # Provide a factory of the models useds on system
  gem 'factory_girl_rails'
  # Check html asserts and test it
  gem 'selenium-webdriver'
  # RSpec is a testing tool for Ruby, created for behavior-driven development (BDD).
  gem 'rspec-rails'
  gem 'codeclimate-test-reporter', require: nil
end

