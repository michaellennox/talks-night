# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    @session_form = SessionForm.new
  end

  def create
    @session_form = SessionForm.new(session_params)

    respond_to do |format|
      if @session_form.valid?
        session[:user_id] = @session_form.user.id
        format.any { redirect_to root_path }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.js { render status: :unprocessable_entity }
      end
    end
  end

  def destroy
    session.delete(:user_id)

    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
