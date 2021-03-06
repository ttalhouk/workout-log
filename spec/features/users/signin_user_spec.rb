require 'rails_helper'

RSpec.feature "User Sign In" do
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
  end
  scenario "An existing user signs into app" do
    visit '/'
    click_link "Sign In"

    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password

    click_button "Log in"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("logged in as: #{@user.email}")
    expect(page).to_not have_link("Sign In")
    expect(page).to_not have_link("Sign Up")
    expect(page).to have_link("Sign Out")
  end

end
