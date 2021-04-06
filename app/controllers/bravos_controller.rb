class BravosController < ApplicationController
  def index
    @bravo_posts=current_user.bravo_posts
  end

  def create
    @bravo=Bravo.new
    @bravo.user_id=current_user.id
    @bravo.post_id=params[:post_id]
    @bravo.save
    @post=Post.find(@bravo.post_id)
    redirect_to @post, success: '投稿にいいねしました'
  end

  def destroy
    @bravo=Bravo.find_by(post_id: params[:post_id], user_id: current_user.id)
    @post=Post.find(@bravo.post_id)
    @bravo.delete
    redirect_to @post, success: 'いいねを解除しました'
  end
end
