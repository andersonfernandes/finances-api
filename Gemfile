source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.3'

gem 'apipie-rails', '~> 0.5.18'
gem 'bcrypt', '~> 3.1.16'
gem 'bootsnap', '~> 1.7', '>= 1.7.2', require: false
gem 'figaro'
gem 'jwt'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3'
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 6.1', '>= 6.1.3.1'

group :development, :test do
  gem 'bullet'
  gem 'pry', '~> 0.12.2'
  gem 'rubocop', '~> 0.80.1', require: false
end

group :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 4.1', '>= 4.1.2'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end

group :development do
  gem 'annotate'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
