require 'rails_helper'

RSpec.feature "Following Users" do
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
    login_as(@user)
  end
  scenario "User follows another user" do
    visit '/'

    href = "friendships?friend.id=#{@user.id}"
    expect(page).to_not have_link("Follow", href: href)
    href2 = "friendships?friend.id=#{@user2.id}"
    expect(page).to have_link("Follow", href: href2)
    link = "a[href='friendships?friend.id=#{@user2.id}']"

    find(link).click
    expect(page).to_not have_link("Follow", href: href2)
    
  end

end
