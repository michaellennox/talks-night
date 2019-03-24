# frozen_string_literal: true

class SessionForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :email, :string
  attribute :password, :string

  validates :email, presence: true
  validates :password, presence: true
  validate :authenticate

  def self.model_name
    ActiveModel::Name.new(self, nil, "Session")
  end

  def user
    @user ||= User.find_by(email: email)
  end

  private

  def authenticate
    return if user&.authenticate(password)

    errors.add(:email, "Invalid email or password")
    errors.add(:password, "Invalid email or password")
  end
end
