class SessionsController < ApplicationController
  def new
    render :new
  end 

  def create
    user = User.find_by_credentials(session_params)
    if user 
      login!(user)
      redirect_to user_url(user)
    else 
      render :new
    end
  end 

  def delete
    logout!
    redirect_to users_url
  end 

  private 
  def session_params 
    params.require(:user).permit(:username, :password)
  end 
end
