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
    @exercise1 = @user.exercises.create(duration:22,workout:'Jogging', workout_date:Date.today)

    @exercise2 = @user2.exercises.create(duration:40,workout:'Leg Day', workout_date:2.days.ago)

  end
  scenario "User views friends workout page" do
    visit '/'
    click_link "My Lounge"
    click_link @user2.full_name

    expect(page).to have_content(@exercise2.workout)
    expect(page).to have_content(@exercise2.duration)
    expect(page).to have_css('div#chart')

  end

end
