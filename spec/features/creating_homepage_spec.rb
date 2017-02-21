require 'rails_helper'

RSpec.feature "Homepage Layout" do
  scenario "A user visits the home page of the app" do
    visit '/'

    expect(page).to have_link("Home")
    expect(page).to have_link("Atheletes Den")
    expect(page).to have_content("Workout Lounge!")
    expect(page).to have_content("Show off your workout")

  end

end
