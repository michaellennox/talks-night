# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  it { should have_secure_password }

  it { should have_db_index(:email).unique(true) }
  it { should have_db_index(:display_name).unique(true) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:display_name) }

  context "uniqueness" do
    subject { FactoryBot.create(:user) }

    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:display_name) }
  end
end
