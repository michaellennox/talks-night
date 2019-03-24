# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :display_name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
