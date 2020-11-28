source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'apipie-rails', '~> 0.5.18'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'figaro'
gem 'jwt'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.12'
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 6.0', '>= 6.0.3.4'
gem 'simple_command'

group :development, :test do
  gem 'pry', '~> 0.12.2'
  gem 'rubocop', '~> 0.80.1', require: false
end

group :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 3.8'
  gem 'shoulda-matchers'
end

group :development do
  gem 'annotate'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
