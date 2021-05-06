class BravosController < ApplicationController
  before_action :set_post_search_query
  before_action :authenticate_user, except: [:index]

  def new
    @post = Post.find(params[:post_id])
    @bravo = Bravo.new
  end

  def create
    @post = Post.find(params[:post_id])
    @bravo = current_user.bravos.new(bravo_params)
    @bravo.post_id = params[:post_id]
    if @bravo.save
      redirect_to @bravo.post, success: '投稿にいいねしました'
    else
      render :new
    end
  end

  def index
    @bravos = Bravo.where(post_id: params[:post_id]).page(params[:page]).per(10).order(created_at: :desc)
  end

  def destroy
    @bravo = Bravo.find_by(post_id: params[:post_id], user_id: current_user.id)
    @post = Post.find(@bravo.post_id)
    @bravo.delete
    redirect_to @post, success: 'いいねを解除しました'
  end

  private
    def bravo_params
      params.require(:bravo).permit(:bravo_tag_id)
    end
end
