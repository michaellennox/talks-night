# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    return render :new unless @user.save

    session[:user_id] = @user.id
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:display_name, :email, :password)
  end
end
