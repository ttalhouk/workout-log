require 'rails_helper'

RSpec.feature "Create Exercise" do
  before do
    @user = User.create!(email: "bob@example.com", password:"password")
    @user2 = User.create!(email: "bill@example.com", password:"password")
  end
  scenario "as logged in user" do
    login_as(@user)
    visit '/'

    click_link "My Lounge"
    click_link "New Workout"

    expect(current_path).to  eq(new_user_exercise_path(@user))
    expect(page).to have_link('Back')

    fill_in "Duration (min)", with: 20
    fill_in "Workout Details", with: "Jogging"
    fill_in "Activity Date", with:"2017-01-01"
    click_button "Create Exercise"

    expect(page).to have_content('Exercise has been created')
    @exercise = Exercise.last
    expect(current_path).to eq(user_exercise_path(@user,@exercise))
    expect(@exercise.user_id).to eq(@user.id)

  end

  scenario "with missing field information" do
    login_as(@user)
    visit new_user_exercise_path(@user)
    fill_in "Duration (min)", with: ""
    fill_in "Workout Details", with: ""
    fill_in "Activity Date", with:""
    click_button "Create Exercise"
    expect(page).to have_content('Exercise could not be created')

    expect(page).to have_content('Duration can\'t be blank')
    expect(page).to have_content('Workout details can\'t be blank')
    expect(page).to have_content('Activity date can\'t be blank')
  end

  scenario "with string for duration" do
    login_as(@user)
    visit new_user_exercise_path(@user)
    fill_in "Duration (min)", with: "twenty"
    fill_in "Workout Details", with: "Jogging"
    fill_in "Activity Date", with:"2017-01-01"
    click_button "Create Exercise"
    expect(page).to have_content('Exercise could not be created')
    expect(page).to have_content("Duration is not a number")
  end

end
