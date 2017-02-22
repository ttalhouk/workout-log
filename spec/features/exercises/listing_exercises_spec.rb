require 'rails_helper'

RSpec.feature "Listing Users Exercises" do
  before do
    @user = User.create!(email: "bob@example.com", password:"password")
    @user2 = User.create!(email: "bill@example.com", password:"password")
    login_as(@user)
    @exercise1 = @user.exercises.create(duration:20,workout:'Jogging', workout_date:Date.today)

    @exercise2 = @user.exercises.create(duration:40,workout:'Leg Day', workout_date:2.days.ago)

    @exercise3 = @user.exercises.create(duration:60,workout:'swimming', workout_date:10.days.ago)
  end
  scenario "show last 7 days of workouts" do
    visit '/'

    click_link "My Lounge"

    expect(page).to have_content(@exercise1.duration)
    expect(page).to have_content(@exercise1.workout)
    expect(page).to have_content(@exercise1.workout_date)

    expect(page).to have_content(@exercise2.duration)
    expect(page).to have_content(@exercise2.workout)
    expect(page).to have_content(@exercise2.workout_date)

    # expect(page).to have_content(@exercise3.duration)
    # expect(page).to have_content(@exercise3.workout)
    # expect(page).to have_content(@exercise3.workout_date)


  end
end
