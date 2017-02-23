require 'rails_helper'

RSpec.feature "User Sign up" do
  scenario "A user signs up for the app" do
    visit '/'

    click_link "Sign Up"

    @email = "bob@example.com"

    fill_in "First Name", with: "John"
    fill_in "Last Name", with: "Doe"
    fill_in "Email", with: @email
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_button "Sign up"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You have signed up successfully.")
    expect(page).to have_content("logged in as: #{@email}")
    expect(page).to_not have_link("Sign In")
    expect(page).to_not have_link("Sign Up")
    expect(page).to have_link("Sign Out")

  end
  scenario "A user signs up with invalid credentials" do
    visit '/'

    click_link "Sign Up"

    @email = "bob@example.com"

    fill_in "First Name", with: ""
    fill_in "Last Name", with: ""
    fill_in "Email", with: @email
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_button "Sign up"

    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")


  end

end
