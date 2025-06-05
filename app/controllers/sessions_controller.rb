class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by({ "email" => params["email"] })

    if user
      if BCrypt::Password.new(user["password_digest"]) == params["password"]
        session["user_id"] = user["id"]
        flash[:notice] = "Login successful!"
        redirect_to "/places"
      else
        flash[:alert] = "Incorrect password"
        redirect_to "/sessions/new"
      end
    else
      flash[:alert] = "No user with that email"
      redirect_to "/sessions/new"
    end
  end

  def destroy
    session["user_id"] = nil
    flash[:notice] = "Logged out!"
    redirect_to "/"
  end
end

