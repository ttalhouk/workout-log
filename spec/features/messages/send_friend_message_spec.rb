require 'rails_helper'

RSpec.feature "Sending Messages" do
  before do
    @user = User.create!(
      first_name:'Bob',
      last_name:'Job',
      email: "bob@example.com",
      password:"password"
    )
    @user2 = User.create!(
      first_name:'Suzy',
      last_name:"Smith",
      email: "sue@example.com",
      password:"password"
    )
    @user3 = User.create!(
      first_name:'John',
      last_name:"Hennry",
      email: "john@example.com",
      password:"password"
    )
    @room_name = @user.room.name
    @room = @user.room

    login_as(@user)
    @user3.friendships.create(friend: @user)
    @user2.friendships.create(friend: @user)
  end
  scenario "to followers in chat window" do
    visit '/'

    click_link "My Lounge"

    expect(page).to have_content(@room_name)

    fill_in "message-field", with: "Hello"
    click_button "Post"

    expect(page).to have_content("Hello")

    within("#followers") do
      expect(page).to have_link(@user2.full_name)
      expect(page).to have_link(@user3.full_name)
    end
  end
end
