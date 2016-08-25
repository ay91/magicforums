require "rails_helper"

RSpec.feature "User Management", type: :feature, js: true do
  before(:all) do
    @user = create(:user)
  end

  scenario "User Login" do
    visit("http://localhost:3000")
    click_button('Login')
    fill_in 'email', with: 'ironman@email.com'
    fill_in 'password', with: 'password'
    click_button('Login')

    user = User.find_by(email: "ironman@email.com")
    expect(user).
  end
end
