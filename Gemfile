source 'https://rubygems.org'
ruby '2.6.10'

gem 'sassc-rails'
gem 'bootsnap'
gem 'devise'
gem 'devise-i18n'
gem 'jquery-rails'
gem 'rails', '~> 5.2'
gem 'russian' 
gem 'twitter-bootstrap-rails'
gem 'uglifier', '>= 1.3.0'
gem 'skeleton'
gem 'coffee-rails'
gem 'dotenv-rails'
gem "image_processing", ">= 1.2"
gem 'sprockets'
gem 'listen'
gem "font-awesome-rails"
gem "aws-sdk-s3", require: false
gem "active_storage_validations"

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'byebug'
  gem 'sqlite3'
end

group :development do
  gem 'capistrano', '~> 3.8'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-passenger', '~> 0.2'
  gem 'capistrano-rbenv', '~> 2.1'
  gem 'capistrano-bundler', '~> 1.2'

  gem 'ed25519', '>= 1.2', '< 2.0'
  gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'
end