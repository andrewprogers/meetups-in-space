class Rsvp < ActiveRecord::Base
  belongs_to :meetup
  belongs_to :attendee, class_name: "User"
end
