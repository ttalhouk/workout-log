require 'rails_helper'

RSpec.feature "Create Exercise" do
  before do
    @user = User.create!(email: "bob@example.com", password:"password")
    @user2 = User.create!(email: "bill@example.com", password:"password")
    login_as(@user)
  end
  scenario "as logged in user" do
    login_as(@user)
    visit '/'

    click_link "My Lounge"
    click_link "New Workout"

    expect(current_path).to  eq(new_user_exercise_path(@user))
    expect(page).to have_link('Back')

    fill_in "Duration", with: 20
    fill_in "Workout Details", with: "Jogging"
    fill_in "Activity Date", with:"2017-01-01"
    click_button "Create Exercise"

    expect(page).to have_content('Exercise has been created')
    @exercise = Exercise.last
    expect(current_path).to eq(user_exercise_path(@user,@exercise)
    expect(@exercise.user_id).to eq(@user.id)




  end

  scenario "as a non logged in user" do


  end

end
