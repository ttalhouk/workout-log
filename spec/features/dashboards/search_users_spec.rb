require 'rails_helper'

RSpec.feature "Search for Users" do
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
  scenario "enter name search" do
    visit '/'

    fill_in "search_name", with: 'smith'
    click_button 'Search'

    expect(page).to have_content(@user2.full_name)
    expect(page).to_not have_content(@user.full_name)
    expect(current_path).to eq("/dashboards/search")

  end

end
