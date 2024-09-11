class RegistrationController < ApplicationController
    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)

      if @user.save
        redirect_to log_in_path, status: "Successfully created account!"
      else
        redirect_to root_path, notice:  :see_other
      end
    end

    private
    def user_params
      params.require("user").permit(:username, :email, :password, :password_confirmation)
    end
end
