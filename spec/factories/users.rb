# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    display_name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
  end
end
