# frozen_string_literal: true

module Requests
  module SessionManagement
    def login(user)
      post sessions_path, params: { session: { email: user.email, password: user.password } }
    end
  end
end

RSpec.configure do |config|
  config.include Requests::SessionManagement, type: :request
end
