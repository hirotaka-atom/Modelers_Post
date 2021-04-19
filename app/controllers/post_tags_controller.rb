class PostTagsController < ApplicationController
  before_action :set_post_search_query
  
  def new
    @post_tag = PostTag.new
  end

  def create
    @post_tag = PostTag.new(post_tag_params)
    if @post_tag.save
      redirect_to post_tags_path, success: "投稿用タグを作成しました"
    else
      flash.now[:danger] = "投稿用タグ作成に失敗しました"
      render :new
    end
  end

  def index
    @post_tags = PostTag.order(created_at: :desc)
  end

  def edit
    @post_tag = PostTag.find(params[:id])
  end

  def update
    @post_tag = PostTag.find(params[:id])
    if @post_tag.update(post_tag_params)
      redirect_to post_tags_path, success: "投稿用タグを編集しました"
    else
      flash.now[:danger] = "投稿用タグの編集に失敗しました"
      render :edit
    end
  end

  def destroy
    PostTag.find(params[:id]).delete
    redirect_to post_tags_path, success: "投稿用タグを削除しました"
  end

  private
    def post_tag_params
      params.require(:post_tag).permit(:name)
    end
end
