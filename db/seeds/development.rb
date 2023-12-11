# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(
  email:"renny@test.com",
  username:"renny",
  password:"password",
  password_confirmation:"password",
  role: User.roles[:admin]
  )

User.create(
  email:"test@test.com",
  username:"bob",
  password:"password",
  password_confirmation:"password"
  )

articles = []
comments = []
#TODO use faker gem to generate random data ... look into faker gem
elapsed_time = Benchmark.measure do
  1000.times do |x|
    puts "Creating article #{x+1}"
     article = Article.new(
      title:"Title #{x+1}",
      body:"#{x} lorem ipsum dorem....",
      status:"public",
      user_id: User.first.id)
      articles.push(article)

      10.times do |y|
        puts "Creating comment #{y+1} for article #{x+1} out of 100"
        comment = article.comments.new(
          body:"#{y} Comment ipsum dorem....",
          status:"public",
          user_id: User.second.id)
        comments.push(comment)
      end
  end
end
#uses gem actriverecord-import only works with postgresql
Article.import(articles)
Comment.import(comments)

puts "created #{articles.count} articles and #{comments.count} comments in #{elapsed_time.real} seconds"
