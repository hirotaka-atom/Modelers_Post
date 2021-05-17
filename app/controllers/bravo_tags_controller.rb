class BravoTagsController < ApplicationController
  before_action :set_post_search_query
  before_action :authenticate_admin

  def new
    @bravo_tag = BravoTag.new
  end

  def create
    @bravo_tag = BravoTag.new(bravo_tag_params)
    if @bravo_tag.save
      redirect_to bravo_tags_path, success: "いいね用タグを作成しました"
    else
      render :new
    end
  end

  def index
    @bravo_tags = BravoTag.page(params[:page]).per(20).order(created_at: :desc)
  end

  def edit
    @bravo_tag = BravoTag.find(params[:id])
  end

  def update
    @bravo_tag = BravoTag.find(params[:id])
    if @bravo_tag.update(bravo_tag_params)
      redirect_to bravo_tags_path, success: "いいね用タグを編集しました"
    else
      render :edit
    end
  end

  def destroy
    BravoTag.find(params[:id]).delete
    redirect_to bravo_tags_path, success: "いいね用タグを削除しました"
  end

  private
  
    def bravo_tag_params
      params.require(:bravo_tag).permit(:name)
    end
end
