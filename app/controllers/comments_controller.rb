class CommentsController < ApplicationController
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
      flash.now[:danger] = "コメントの投稿に失敗しました"
      render :new
    end
  end

  def index
    @comments = Comment.order(created_at: :desc)
  end

  def show
    @comment = Comment.find(params[:id])
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
      flash.now[:danger] = "コメントの編集に失敗しました"
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
