source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.0'

gem 'rails', '~> 7.0.6'
gem 'pg'
gem 'puma', '~> 5.0'
# gem 'jbuilder'
# gem 'redis', '~> 4.0'
# gem 'kredis'
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]
gem 'bootsnap', require: false
# gem 'image_processing', '~> 1.2'
gem 'rack-cors'
gem 'bcrypt', '~> 3.1.7'
gem 'jwt'

group :development, :test do
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
  gem 'dotenv-rails'
  gem 'rspec-rails'
end

group :development do
  # gem 'spring'
end

group :test do
  gem 'database_cleaner-active_record'
end
