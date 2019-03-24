# frozen_string_literal: true

FactoryBot.define do
  factory :session_form do
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    skip_create
  end
end
