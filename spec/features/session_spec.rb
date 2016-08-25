require "rails_helper"

RSpec.feature "User Management", type: :feature, js: true do
  before(:all) do
    @user = create(:user)
  end

  scenario "User Login, update profile and logout" do
    visit("http://localhost:3000")
    click_button('Login')
    fill_in 'email', with: 'user@email.com'
    fill_in 'password', with: 'password'
    click_button('Log in')
    user = User.find_by(email: "user@email.com")
    expect(find('.flash-messages .message').text).to eql("Welcome back #{user.username}")

    click_button("close-button")

    click_link("bob")
    fill_in "user_username_field", with: "cat"
    fill_in "user_email_field", with: "user_test@gmail.com"
    click_button("Update Profile")

    expect(find(".flash-messages .message").text).to eql("You've updated your details")

    click_button("close-button")

    click_link('Logout')
    expect(page).to have_current_path(root_path)
    expect(find('.flash-messages .message').text).to eql("You've been logged out")
  end
end
