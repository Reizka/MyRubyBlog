# Use an official Ruby runtime as a parent image
FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set work directory
WORKDIR /myapp

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# Install gems
RUN bundle install

# Copy the main application
COPY . /myapp
# Add a script to be executed every time the container starts
# Checks that no double rails server is running
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expose the port the app runs on
EXPOSE 3000

# Start the main process (Rails server)
CMD ["rails", "server", "-b", "0.0.0.0"]