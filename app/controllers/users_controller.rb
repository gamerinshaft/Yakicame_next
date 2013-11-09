class UsersController < ApplicationController

  def index
  	@users = User.all

  	
  end

  def show
  	@user = User.find(params[:id])
    @users = User.all
  	
  	# @followers = User.find(@user.inverse_follows.pluck(user_id))
  	# @follwer = Follow.find(params[:id])
  	# @follower = User.find(@user.inverse_follows.user_id)
  end
end
