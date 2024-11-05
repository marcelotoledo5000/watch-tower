# frozen_string_literal: true

source 'https://rubygems.org'

# Use specific branch of Rails
gem 'rails', github: 'rails/rails', branch: '7-2-stable'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem 'kredis'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem 'jbuilder'
gem 'active_model_serializers', '~> 0.10.14'
# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'bcrypt', '~> 3.1'
gem 'bootsnap', require: false
gem 'cancancan', '~> 3.6', '>= 3.6.1'
gem 'devise-jwt', '~> 0.12.1'
gem 'dotenv-rails', '~> 3.1', '>= 3.1.4'
gem 'kaminari', '~> 1.2'
gem 'pg', '~> 1.5'
gem 'puma', '~> 6.4'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
gem 'rack-cors'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  # gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem 'brakeman', require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem 'rubocop-rails-omakase', require: false

  gem 'codecov', require: false
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'rubycritic'
  gem 'shoulda-matchers'
  gem 'simplecov'
end
