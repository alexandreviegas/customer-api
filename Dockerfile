FROM ruby:3.0.2

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

# confir main working directory
WORKDIR /var/app

# copy Gemfile and Gemfile.lock and install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# copy entire application to container
COPY . .

# run migrations and seed data
RUN rails db:migrate db:seed

RUN chmod +x entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]

# expose port 3000 to Docker host
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
