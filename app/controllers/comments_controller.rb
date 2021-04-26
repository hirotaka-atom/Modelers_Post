class CommentsController < ApplicationController
  before_action :set_post_search_query

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]
    if @comment.save
      redirect_to @comment.post, success: "コメントを投稿しました"
    else
      render :new
    end
  end

  def index
    @comments = Comment.where(post_id: params[:post_id]).page(params[:page]).per(10).order(created_at: :desc)
  end

  def edit
    @post=Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @post=Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @comment.post, success: "コメントを編集しました"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    Comment.find(params[:id]).delete
    redirect_to @post, success: "コメントを削除しました"
  end

  private
    def comment_params
      params.require(:comment).permit(:image, :content)
    end
end
