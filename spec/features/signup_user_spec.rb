require 'rails_helper'

RSpec.feature "User Sign up" do
  scenario "A user signs up for the app" do
    visit '/'
    click_link "Sign Up"

    @email = "bob@example.com"

    fill_in "Email", with: @email
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_button "Sign up"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You have signed up successfully.")
    expect(page).to have_content("welcome: #{@email}")

  end

end