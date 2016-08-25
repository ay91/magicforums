require "rails_helper"

RSpec.feature "User Management", type: :feature, js: true do
  before(:all) do
    @user = create(:user)
  end

  scenario "User registers" do

    visit("http://localhost:3000")
    click_button('Register')
    fill_in 'Username', with: 'ironman'
    fill_in 'user[email]', with: 'ironman@email.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'


    click_button('Sign Up')

    user = User.find_by(email: "ironman@email.com")

    expect(User.count).to eql(2)
    expect(user).to be_present
    expect(user.email).to eql("ironman@email.com")
    expect(user.username).to eql("ironman")
    expect(find('.flash-messages .message').text).to eql("You have successfully registered!")
    expect(page).to have_current_path(root_path)
  end
end
