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
    expect(page).to have_button "Log out"
  end

  it "allows a user to login to an existing account" do
    user = FactoryBot.create(:user)

    visit root_path

    click_on "Log in"

    within "#session-form" do
      fill_in "Email", with: user.email
      fill_in "Password", with: "notthepass"

      click_on "Log in"
    end

    expect(page).to have_content "Invalid email or password"

    within "#session-form" do
      fill_in "Password", with: user.password

      click_on "Log in"
    end

    expect(page).not_to have_link "Log in"
    expect(page).to have_button "Log out"
  end

  it "allows a logged in user to log out" do
    user = FactoryBot.create(:user)
    login(user)

    click_on "Log out"

    expect(page).not_to have_button "Log out"
    expect(page).to have_link "Log in"
  end
end
