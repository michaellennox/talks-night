# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "GET /users/new" do
    subject(:get_new_user) { get "/users/new" }

    it "contains a form to create a new user" do
      get_new_user

      expect(page).to have_css "#user-form" do |form|
        expect(form).to have_field name: "user[display_name]"
        expect(form).to have_field name: "user[email]"
        expect(form).to have_field name: "user[password]"
      end
    end
  end

  describe "POST /users" do
    subject(:post_users) { post "/users", params: { user: params } }

    context "with valid parameters" do
      let(:params) { FactoryBot.attributes_for :user }

      it "creates a user with those attributes" do
        expect { post_users }.to change(User, :count).by 1

        user = User.last

        expect(user).to have_attributes params.except(:password)
        expect(user.authenticate(params[:password])).to be_truthy
      end

      it "redirects to the root" do
        post_users

        expect(response).to redirect_to root_path
      end

      it "sets the user id in the session" do
        post_users

        expect(session[:user_id]).to eq User.last.id
      end
    end

    context "with invalid parameters" do
      let(:params) { { display_name: "" } }

      it "does not set the session key" do
        post_users

        expect(session[:user_id]).to be nil
      end

      it "is unprocessable" do
        post_users

        expect(response).to have_http_status :unprocessable_entity
      end

      it "does not create a user" do
        expect { post_users }.not_to change User, :count
      end

      it "re-renders the form with validation errors" do
        post_users

        expect(page).to have_css "#user-form" do |form|
          expect(form).to have_field name: "user[display_name]", class: "is-danger"
          expect(form).to have_field name: "user[email]", class: "is-danger"
          expect(form).to have_field name: "user[password]", class: "is-danger"

          expect(form).to have_content "Display name can't be blank"
          expect(form).to have_content "Email can't be blank"
          expect(form).to have_content "Password can't be blank"
        end
      end
    end
  end
end
