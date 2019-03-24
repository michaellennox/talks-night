# frozen_string_literal: true

module System
  module SessionManagement
    def login(user)
      visit new_session_path

      within "#session-form" do
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password

        click_on "Log in"
      end
    end
  end
end

RSpec.configure do |config|
  config.include System::SessionManagement, type: :system
end
