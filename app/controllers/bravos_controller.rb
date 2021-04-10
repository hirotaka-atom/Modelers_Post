class BravosController < ApplicationController
  def new
    @post=Post.find(params[:post_id])
    @bravo=Bravo.new
    @bravo_tags=BravoTag.all
  end

  def create
    @post=Post.find(params[:post_id])
    @bravo = current_user.bravos.new(bravo_params)
    @bravo.post_id = params[:post_id]
    if @bravo.save
      redirect_to @bravo.post, success: '投稿にいいねしました'
    else
      flash.now[:danger]="いいねに失敗しました"
      render :new
    end
  end

  def index
    @bravo_posts=Bravo.order(created_at: :desc)
  end

  def edit
    @post=Post.find(params[:post_id])
    @bravo=Bravo.find(params[:id])
    @bravo_tags=BravoTag.all
  end

  def update
    @post=Post.find(params[:post_id])
    @bravo = Bravo.find(params[:id])
    if @bravo.update(bravo_params)
      redirect_to @bravo.post, success: "いいねの内容を編集しました"
    else
      flash.now[:danger] = "いいねの内容の編集に失敗しました"
      render :edit
    end
  end

  def destroy
    @bravo=Bravo.find_by(post_id: params[:post_id], user_id: current_user.id)
    @post=Post.find(@bravo.post_id)
    @bravo.delete
    redirect_to @post, success: 'いいねを解除しました'
  end

  private
    def bravo_params
      params.require(:bravo).permit(:bravo_tag_id)
    end
end
