# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version
  3.2.2
- System dependencies

- Configuration

- Database creation
  PostgresSQL db

- Database initialization
  #If setting up a new db
  // POSTGRES_USER = renny
  // POSTGRES_PASSWORD = password
  // POSTGRES_DATABASE = demodb
  // psql -U renny
  //check everything is tip top
- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions
  rails db:drop (if first time in a while)
  rails db:create (--"--)

  double check rails encrypted env files
  EDITOR="code --wait" rails credentials:edit

  setup db
  bin/rails db:migrate RAILS_ENV=development
  rails db:seed
