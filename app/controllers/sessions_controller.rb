# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    @session_form = SessionForm.new
  end
end
