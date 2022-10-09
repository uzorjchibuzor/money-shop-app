class SessionsController < ApplicationController

  def new

  end

  def log_in
    @user = User.find_by_username(params[:user][:username])
    if @user && @user.authenticate(params[:user][:password])
      session[:username] = params[:user][:username]
      redirect_to root_path, notice: "Signed in successfully!" 
    else
      puts @user.authenticate(params[:user][:password]) if @user
      render :new, status: :unprocessable_entity
    end
  end

  def log_out
    session[:username] = nil
    redirect_to sign_in_path, notice: "Signed out successfully!"
  end
end