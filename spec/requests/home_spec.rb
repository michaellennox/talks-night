# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Home", type: :request do
  describe "GET /" do
    it "contains a CTA to claim your group" do
      get "/"

      expect(page).to have_link "Claim your group", href: "#"
    end
  end
end
