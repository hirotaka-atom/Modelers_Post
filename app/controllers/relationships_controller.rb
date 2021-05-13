class RelationshipsController < ApplicationController

  def create
    following = current_user.follow(follow_params)
    following.save
    flash[:success] = 'ユーザーをフォローしました'
    redirect_to @user
  end

  def destroy
    following = current_user.unfollow(follow_params)
    following.destroy
    flash[:success] = 'ユーザーのフォローを解除しました'
    redirect_to @user
  end

  private

  def follow_params
    @user = User.find(params[:follow_id])
  end

end
