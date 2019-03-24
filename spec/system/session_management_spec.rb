# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Session Management", type: :system do
  it "allows a user to register an account" do
    visit root_path

    click_on "Sign up"

    fill_in "Email", with: "joe.blogs@example.com"
    fill_in "Password", with: "SuperPassword123!"

    click_on "Create User"

    expect(page).to have_content "Display name can't be blank"

    fill_in "Display Name", with: "Joe Blogs"
    fill_in "Password", with: "SuperPassword123!"

    click_on "Create User"

    expect(page).not_to have_link "Sign up"
    expect(page).to have_link "Log out"
  end
end
