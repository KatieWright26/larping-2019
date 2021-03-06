# frozen_string_literal: true

ruby File.read('.ruby-version')

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end
source 'https://rubygems.org'

gem 'autoprefixer-rails'
gem 'codecov', require: false, group: :test
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'dotenv-rails'
gem 'factory_bot_rails'
gem 'faker'
gem 'font-awesome-sass', '~> 5.9.0'
gem 'foundation-rails'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection', '~> 0.1'
gem 'pg'
gem 'pry-byebug'
gem 'puma', '~> 3.12'
gem 'pundit'
gem 'rails', '~> 5.2.3'
gem 'rubocop', require: false
gem 'sass-rails', '~> 5.0'
gem 'simplecov', require: false
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', '~> 4.x'
group :development, :test do
  gem 'capybara', '~> 2.13'
  gem 'database_cleaner'
  gem 'rails-controller-testing'
  gem 'rb-readline'
  gem 'rspec-rails', '~> 3.5'
  gem 'selenium-webdriver'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
