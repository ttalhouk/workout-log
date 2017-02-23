require 'rails_helper'

RSpec.feature "Listing Users Exercises" do
  before do
    @user= User.create!(
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
    @exercise1 = @user.exercises.create(duration:20,workout:'Jogging', workout_date:Date.today)

    @exercise2 = @user.exercises.create(duration:40,workout:'Leg Day', workout_date:2.days.ago)

    @exercise3 = @user.exercises.create(duration:60,workout:'swimming', workout_date:8.days.ago)
  end
  scenario "Show last 7 days of workouts" do
    visit '/'

    click_link "My Lounge"

    expect(page).to have_content(@exercise1.duration)
    expect(page).to have_content(@exercise1.workout)
    expect(page).to have_content(@exercise1.workout_date)

    expect(page).to have_content(@exercise2.duration)
    expect(page).to have_content(@exercise2.workout)
    expect(page).to have_content(@exercise2.workout_date)

    expect(page).to_not have_content(@exercise3.duration)
    expect(page).to_not have_content(@exercise3.workout)
    expect(page).to_not have_content(@exercise3.workout_date)
  end

  scenario "No workouts to list" do
    @user.exercises.delete_all

    visit '/'

    click_link "My Lounge"

    expect(page).to_not have_content(@exercise1.duration)
    expect(page).to_not have_content(@exercise1.workout)
    expect(page).to_not have_content(@exercise1.workout_date)

    expect(page).to_not have_content(@exercise2.duration)
    expect(page).to_not have_content(@exercise2.workout)
    expect(page).to_not have_content(@exercise2.workout_date)

    expect(page).to have_content('No Workouts')
  end
end
