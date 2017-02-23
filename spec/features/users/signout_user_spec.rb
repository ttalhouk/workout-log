require 'rails_helper'

RSpec.feature "User Sign Out" do
  before do
    @user= User.create!(
      first_name:'Bob',
      last_name:'Job',
      email: "bob@example.com",
      password:"password"
    )

    visit '/'

    click_link "Sign In"
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password

    click_button "Log in"
  end
  scenario "An signed in user signs out of app" do
    visit '/'
    click_link "Sign Out"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Signed out successfully.")
    expect(page).to_not have_content("logged in as: #{@user.email}")
    expect(page).to_not have_link("Sign Out")

  end

end
