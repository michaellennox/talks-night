# frozen_string_literal: true

module Requests
  module CapybaraResponseWrapper
    RSpec.configure do |config|
      config.include self, type: :request
    end

    def page
      Capybara::Node::Simple.new(response.body)
    end
  end
end
