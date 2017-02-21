require 'rails_helper'

RSpec.feature "User Sign In" do
  before do
    @user = User.create!(email: "bob@example.com", password:"password")
  end
  scenario "An existing user signs into app" do
    visit '/'
    click_link "Sign In"

    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password

    click_button "Log in"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("welcome: #{@user.email}")

  end

end
