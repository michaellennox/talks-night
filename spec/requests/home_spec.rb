# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Home", type: :request do
  describe "GET /" do
    it "contains buttons linking to login or claim a space" do
      get "/"

      expect(page).to have_link "Claim your group", href: "#"
      expect(page).to have_link "Login", href: "#"
    end
  end
end
