require 'rails_helper'

RSpec.feature "Editing Users Exercises" do
  before do
    @owner= User.create!(
      first_name:'Bob',
      last_name:'Job',
      email: "bob@example.com",
      password:"password"
    )
    @viewer = User.create!(
      first_name:'Suzy',
      last_name:"Smith",
      email: "sue@example.com",
      password:"password"
    )
    @exercise1 = @owner.exercises.create(duration:40,workout:'Jogging', workout_date:Date.today)

    # @exercise2 = @owner.exercises.create(duration:40,workout:'Leg Day', workout_date:2.days.ago)
    #
    # @exercise3 = @owner.exercises.create(duration:60,workout:'swimming', workout_date:8.days.ago)
  end
  scenario "Owner edits their workout" do
    login_as(@owner)
    visit '/'

    path = "/users/#{@owner.id}/exercises/#{@exercise1.id}/edit"
    link = "a[href=\'#{path}'\]"
    click_link "My Lounge"
    find(link).click
    expect(current_path).to eq(edit_user_exercise_path(@owner, @exercise1))

    fill_in "Duration (min)", with: 30
    fill_in "Workout Details", with: "Walking"

    click_button "Update Exercise"

    expect(page).to have_content('Exercise has been updated')
    expect(current_path).to eq(user_exercise_path(@owner,@exercise1))
    expect(page).to have_content(30)
    expect(page).to have_content("Walking")
    expect(page).to_not have_content(40)
    expect(page).to_not have_content("Jogging")

  end
end
