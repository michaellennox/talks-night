# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Session Management", type: :system do
  it "allows a user to create an account from a link on the hompage" do
    pending

    visit root_path

    click_on "Sign up"

    fill_in "Display Name", with: "Joe Blogs"
    fill_in "Email", with: "joe.blogs@example.com"
    fill_in "Password", with: "SuperPassword123!"

    expect(page).not_to have_link("Sign up")
  end
end
