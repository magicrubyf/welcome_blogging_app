class SessionsController < ApplicationController

  def create
    if user = User.find_or_create_from_auth_hash(auth_hash)
      session[:user_info]=auth_hash
      flash[:success]="You are successfully logged in."
      redirect_to user_posts_path(current_user)
    else
      flash[:danger]="Something went wrong, try again"
      redirect_to root_path
    end
  end

  def destroy
    session[:user_info]=nil
    redirect_to root_path
  end


  private

  def auth_hash
    auth_hash=request.env['omniauth.auth']
    auth_hash['credentials']['token']= User.extend_auth(auth_hash['credentials']['token'])
    return auth_hash
  end

end
