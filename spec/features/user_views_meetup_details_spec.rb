require 'spec_helper'

feature 'user views meetup details' do
  # As a user
  # I want to view the details of a meetup
  # So that I can learn more about its purpose
  # Acceptance Criteria:
  #
  # On the index page, the name of each meetup should be a link to the meetup's show page.
  # On the show page, I should see the name, description, location, and the creator of the meetup.

  scenario 'user clicks on a meetup name' do
    u = User.create(
          provider: "github",
          uid: "1",
          username: "jarlax1",
          email: "jarlax1@launchacademy.com",
          avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
        )

    Meetup.create(location: "here", time: "2017-07-15 15:19:24 UTC", description: 'This is the meetup description', creator: u, name: "A meetup")
    Meetup.create(location: "there", time: "2017-07-15 15:19:24 UTC", description: 'This is the next meetup description', creator: u, name: "C meetup")
    Meetup.create(location: "everywhere", time: "2017-07-15 15:19:24 UTC", description: 'This is the last meetup description', creator: u, name: "B meetup")

    visit '/'
    click_link('B meetup')

    expect(page).to have_content("B meetup")
    expect(page).to have_content("This is the last meetup description")
    expect(page).to have_content("everywhere")
    expect(page).to have_content("jarlax1")

  end
end
