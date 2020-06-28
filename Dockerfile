FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs 
RUN gem install bundler
WORKDIR /finances-api
COPY Gemfile /finances-api/Gemfile
COPY Gemfile.lock /finances-api/Gemfile.lock
RUN bundle install
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
