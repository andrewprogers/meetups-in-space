class Meetup < ActiveRecord::Base
  belongs_to :creator, class_name: "User"

  has_many :rsvps
  has_many :attendees, through: :rsvps, source: :attendee
  validates :name, presence: true
  validates :description, presence: true
  validates :location, presence: true
end
