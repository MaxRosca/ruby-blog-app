class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    puts "hello"
    puts user
    puts user.password_digest
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Successfully logged in"
    else
      flash[:alert] = "Invalid email or password"
      redirect_to log_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully."
  end
end
