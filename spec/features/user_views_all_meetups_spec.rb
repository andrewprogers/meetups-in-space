require 'spec_helper'

feature 'user views all meetups' do

# As a user
# I want to view a list of all available meetups
# So that I can get together with people with similar interests
#
#  Acceptance Criteria:
#
#   -On the meetups index page, I should see the name of each meetup.
#   -Meetups should be listed alphabetically.

  scenario 'Meetups are created in non alphabetical order' do
    u = User.create(
          provider: "github",
          uid: "1",
          username: "jarlax1",
          email: "jarlax1@launchacademy.com",
          avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
        )

    Meetup.create(location: "here", time: "2017-07-15 15:19:24 UTC", description: 'This is the meetup description', creator: u, name: "A meetup")
    Meetup.create(location: "here", time: "2017-07-15 15:19:24 UTC", description: 'This is the meetup description', creator: u, name: "C meetup")
    Meetup.create(location: "here", time: "2017-07-15 15:19:24 UTC", description: 'This is the meetup description', creator: u, name: "B meetup")

    visit '/'
    expect(page).to have_content("A meetup B meetup C meetup")
  end
end
