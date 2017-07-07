# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Example:
#
#   Person.create(first_name: 'Eric', last_name: 'Kelly')
require 'faker'

100.times do |idx|
  User.create(provider: "github", email: Faker::Internet.email, username: Faker::Zelda.character, avatar_url: Faker::Avatar.image, uid: idx + 1)
end

20.times do
  Meetup.create(location: Faker::LordOfTheRings.location, time: Faker::Time.forward(23, :morning), description: Faker::Hipster.sentence(3), creator: User.all[rand(101)], name: Faker::LordOfTheRings.character)
end
99.times do |idx|
  Rsvp.create(attendee: User.all[idx], meetup: Meetup.all[rand(10)])
end
