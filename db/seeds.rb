# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

(1..50).each do |i|
  Comment.create!(user_id: 3, post_id: 35, body: %{
      Lorem ipsum dolor sit amet, consectetur adipiscing elit.
  })
end
