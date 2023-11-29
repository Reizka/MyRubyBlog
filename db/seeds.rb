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


10.times do |x|
  Article.create(
    title:"Title#{x+1}", 
    body:"#{x} lorem ipsum dorem....", 
    status:"public", 
    user_id: User.first.id)

    5.times do |y|
      Comment.create(
        body:"#{y} Comment ipsum dorem....", 
        status:"public", 
        user_id: User.second.id,
        article_id: Article.first.id)
    end
end
