require 'rails_helper'

RSpec.feature "Listing Users" do
  before do
    @user = User.create!(
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
  scenario "Show list of all users" do
    visit '/'

    expect(page).to have_content('List of Members')
    expect(page).to have_content(@user.full_name)
    expect(page).to have_content(@user2.full_name)
  end

end
