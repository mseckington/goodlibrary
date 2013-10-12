class RegistrationsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.persisted?
      # sign_in_as @user
      redirect_to root_path
    else
      @user.password_confirmation = user_params[:password_confirmation]
      render :new
    end
  end

  private

  def user_params
    params[:user].permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
