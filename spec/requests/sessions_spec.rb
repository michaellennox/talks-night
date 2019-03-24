# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Sessions", type: :request do
  describe "GET /sessions/new" do
    subject(:get_new_session) { get "/sessions/new" }

    it "contains a form to create a new user" do
      get_new_session

      expect(page).to have_css "form[action=\"/sessions\"]" do |form|
        expect(form).to have_field name: "session[email]"
        expect(form).to have_field name: "session[password]"
      end
    end

    it "is a success" do
      get_new_session

      expect(response).to have_http_status :ok
    end
  end
end
