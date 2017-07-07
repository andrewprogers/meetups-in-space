require 'spec_helper'

feature 'user creates a meetup' do
  # As a user
  # I want to create a meetup
  # So that I can gather a group of people to do an activity
  # Acceptance Criteria:
  #
  #   x-There should be a link from the meetups index page that takes you to the meetups new page. On this page there is a form to create a new meetup.
  #   x-I must be signed in, and I must supply a name, location, and description.
  #   x-If the form submission is successful, I should be brought to the meetup's show page,
  #   and I should see a message that lets me know that I have created a meetup successfully.
  #   x-If the form submission is unsuccessful, I should remain on the meetups new page, and I should see error
  #   messages explaining why the form submission was unsuccessful. The form should be pre-filled with the values
  #   that were provided when the form was submitted.
  let(:user) do
    User.create(
      provider: "github",
      uid: "1",
      username: "jarlax1",
      email: "jarlax1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

  scenario 'user is NOT signed in and clicks on create new meetup' do
    visit '/'
    click_link 'Create A New Meetup'

    expect(page).to_not have_content('Name:')
    expect(page).to_not have_content('Location:')
    expect(page).to_not have_content('Description:')
    expect(page).to have_content('You must be signed in to create a new meetup')
  end

  scenario 'user is signed in and clicks on create new meetup' do
    visit '/'
    sign_in_as user
    expect(page).to have_content "You're now signed in as #{user.username}!"
    click_link 'Create A New Meetup'

    expect(page).to have_content('Name:')
    expect(page).to have_content('Location:')
    expect(page).to have_content('Description:')
  end

  scenario 'user submits valid data using the form' do
    visit '/'
    sign_in_as user
    click_link 'Create A New Meetup'

    fill_in("Name:", with: "Legion of Doom Mixer")
    fill_in("Location:", with: "Floating Skull in the Ocean")
    fill_in("Description:", with: "Come cavort with like-minded evil doers over the hottest new cabs (you probably haven't even heard of them).")
    click_button('Create Meetup!')

    expect(page).to have_content("Your meetup was successfully created")
  end

  scenario 'user makes an invalid submission' do
    visit '/'
    sign_in_as user
    click_link 'Create A New Meetup'

    fill_in("Name:", with: "")
    fill_in("Location:", with: "Floating Skull in the Ocean")
    fill_in("Description:", with: "Come cavort with like-minded evil doers over the hottest new cabs (you probably haven't even heard of them).")
    click_button('Create Meetup!')

    expect(page).to have_content("Name can't be blank")
  end
end
