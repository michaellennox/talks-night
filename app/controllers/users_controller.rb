# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.any { redirect_to root_path }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.js { render status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:display_name, :email, :password)
  end
end
