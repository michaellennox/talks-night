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

  describe "POST /sessions" do
    subject(:post_sessions) { post "/sessions", params: { session: params } }

    context "with valid parameters" do
      let(:user) { FactoryBot.create(:user) }
      let(:params) { FactoryBot.attributes_for :session_form, email: user.email, password: user.password }

      it "redirects to the root" do
        post_sessions

        expect(response).to redirect_to root_path
      end

      it "sets the user id in the session" do
        post_sessions

        expect(session[:user_id]).to eq user.id
      end
    end

    context "with invalid parameters" do
      let(:params) { { email: "" } }

      it "does not set the session key" do
        post_sessions

        expect(session[:user_id]).to be nil
      end

      it "is unprocessable" do
        post_sessions

        expect(response).to have_http_status :unprocessable_entity
      end

      it "re-renders the form with validation errors" do
        post_sessions

        expect(page).to have_css "#session-form" do |form|
          expect(form).to have_field name: "session[email]", class: "is-danger"
          expect(form).to have_field name: "session[password]", class: "is-danger"

          expect(form).to have_content "Invalid email or password"
        end
      end
    end
  end

  describe "DELETE /sessions/current" do
    subject(:delete_session) { delete "/sessions/current" }

    it "removes the session id" do
      user = FactoryBot.create(:user)
      login(user)

      delete_session

      expect(session).not_to have_key(:user_id)
    end

    it "redirects to the root path" do
      delete_session

      expect(response).to redirect_to root_path
    end
  end
end
