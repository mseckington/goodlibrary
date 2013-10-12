class SessionsController < ApplicationController
  def new
    redirect_to(root_path) if signed_in?
  end

  def create
    if signed_in?
      redirect_to root_path
    else
      if user = User.authenticate(params[:email], params[:password])
        sign_in_as user
        redirect_to root_path
      else
        sign_out
        render :new
      end
    end
  end

  def destroy
    if signed_in?
      sign_out
    end
    redirect_to root_path
  end
end
