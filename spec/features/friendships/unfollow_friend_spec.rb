require 'rails_helper'

RSpec.feature "Friend workout page" do
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
    login_as(@user)
    @user.friendships.create(friend: @user2)

  end
  scenario "User views friends workout page" do
    visit '/'
    click_link "My Lounge"
    click_link "Unfollow"

    expect(page).to have_content(@user2.full_name + " was unfollowed")

  end

end
