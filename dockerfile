# Use an official Ruby runtime as a parent image
FROM ruby:3.2.2

# Install Node.js and npm
RUN curl -sL https://deb.nodesource.com/setup_20.9.0 | bash -
RUN apt-get install -y nodejs

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the current directory contents into the container
COPY . .

# Install any needed gems
RUN bundle install

# Add a script to be executed every time the container starts
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expose the port the app runs on
EXPOSE 3000

# Start the main process (Rails server)
CMD ["rails", "server", "-b", "0.0.0.0"]