class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id  # Log in the user
      redirect_to "/places", notice: "Welcome, #{ @user.username }!"
    else
      render :new
    end
  end

  private

  def user_params
    return params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end

