require 'rails_helper'

RSpec.feature "Editing Users Exercises" do
  before do
    @owner = User.create!(email: "bob@example.com", password:"password")
    @viewer = User.create!(email: "bill@example.com", password:"password")
    @exercise1 = @owner.exercises.create(duration:20,workout:'Jogging', workout_date:Date.today)

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
    fill_in "Activity Date", with: 1.day.ago

    xpect(page).to have_content('Exercise has been updated')
    expect(current_path).to eq(user_exercise_path(@owner,@exercise1))
    expect(page).to have_content(30)
    expect(page).to have_content("Walking")
    expect(page).to_not have_content(20)
    expect(page).to_not have_content("Jogging")

  end
end
