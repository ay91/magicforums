require "rails_helper"

RSpec.feature "User adds new comment and deletes it", type: :feature, js: true do

  scenario "User adds, edits, upvotes, downvotes, and delete comment" do
    visit("http://localhost:3000")
    click_button('Login')
    fill_in 'email', with: 'a@a.com'
    fill_in 'password', with: '123'
    click_button('Log in')
    click_button("close-button")

    click_link("Topics")
    click_link("Programming")
    click_link("Controllers")


    fill_in "comment_body_field", with: "New comment"

    click_button "Create Comment"
    expect(page).to have_content("New comment")

    click_button("close-button")

    click_link("Edit")
    within("#comment-update") do
      fill_in "comment_body_field", with: "Edited comment"
    end
    click_button("Update Comment")

    expect(page).to have_content("Edited comment")

    click_button("close-button")

    click_link("Upvote")
    expect(find(".comment-total-votes")).to have_content(1)

    click_button("close-button")

    click_link("Downvote")
    expect(find(".comment-total-votes")).to have_content(-1)

    click_link("Delete")
    page.driver.browser.switch_to.alert.accept
    expect(page).to_not have_content("Edited comment")

  end
end
