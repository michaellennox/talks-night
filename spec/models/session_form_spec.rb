# frozen_string_literal: true

require "rails_helper"

RSpec.describe SessionForm, type: :model do
  describe "#validations" do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }

    it "is invalid when user does not exist" do
      form = FactoryBot.build(:session_form)

      expect(form.valid?).to be false
      expect(form.errors[:base]).to include "Invalid email or password"
    end

    it "is invalid if password is incorrect for user" do
      user = FactoryBot.create(:user)
      form = FactoryBot.build(:session_form, email: user.email)

      expect(form.valid?).to be false
      expect(form.errors[:base]).to include "Invalid email or password"
    end

    it "is valid if correct email and password" do
      user = FactoryBot.create(:user)
      form = FactoryBot.build(:session_form, email: user.email, password: user.password)

      expect(form.valid?).to be true
    end
  end

  describe "::model_name" do
    it "provides the expected activemodel naming to function correctly in a form" do
      model_name = described_class.model_name

      expect(model_name.name).to eq "Session"
      expect(model_name.route_key).to eq "sessions"
    end
  end

  describe "#user" do
    subject(:form) { FactoryBot.build(:session_form, email: user.email) }

    context "when the user exists with the passed email" do
      let!(:user) { FactoryBot.create(:user) }

      it "is the user" do
        expect(form.user).to eq user
      end
    end

    context "when no user exists with the passed email" do
      let(:user) { FactoryBot.build(:user) }

      it "is nil" do
        expect(form.user).to be nil
      end
    end
  end
end
