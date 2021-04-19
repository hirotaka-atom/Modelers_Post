class FavoritesController < ApplicationController
  before_action :set_post_search_query

  def index
    @favorite_posts = current_user.favorite_posts
  end

  def create
    @favorite = Favorite.new
    @favorite.user_id = current_user.id
    @favorite.post_id = params[:post_id]
    @favorite.save
    @post = Post.find(@favorite.post_id)
    redirect_to @post, success: 'お気に入り登録しました'
  end

  def destroy
    @favorite = Favorite.find_by(post_id: params[:post_id], user_id: current_user.id)
    @post = Post.find(@favorite.post_id)
    @favorite.delete
    redirect_to @post, success: 'お気に入りを解除しました'
  end
end
