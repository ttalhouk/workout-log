require 'rails_helper'

RSpec.feature "Editing Users Exercises" do
  before do
    @owner = User.create!(email: "bob@example.com", password:"password")
    @viewer = User.create!(email: "bill@example.com", password:"password")
    @exercise1 = @owner.exercises.create(duration:40,workout:'Jogging', workout_date:Date.today)

    # @exercise2 = @owner.exercises.create(duration:40,workout:'Leg Day', workout_date:2.days.ago)
    #
    # @exercise3 = @owner.exercises.create(duration:60,workout:'swimming', workout_date:8.days.ago)
  end
  scenario "Owner deletes their workout" do
    login_as(@owner)
    visit '/'
    click_link "My Lounge"
    path = "/users/#{@owner.id}/exercises/#{@exercise1.id}"
    link = "//a[contains(@href, \'#{path}\') and .//text()='Delete']"
    find(:xpath, link).click

    expect(page).to have_content('Exercise has been deleted')
    expect(current_path).to eq(user_exercises_path(@owner))
    expect(page).to_not have_content(40)
    expect(page).to_not have_content("Jogging")

  end
end
