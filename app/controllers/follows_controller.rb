# frozen_string_literal: true

# Follows controller: To controller all the methods about follows.
class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to user
  end

  def destroy
    user = Follow.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to user
  end
end
