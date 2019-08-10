class UsersController < ApplicationController

  def index
    @users=User.all
  end

  def show
    @user = User.friendly.find(params[:id])
    @posts=@user.posts
  end

end
