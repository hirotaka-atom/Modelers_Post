class PostsController < ApplicationController
  def new
    @post=Post.new
  end

  def create
    @post=current_user.posts.new(post_params)
    if @post.save
      redirect_to posts_path, success: "新規投稿しました"
    else
      flash.now[:danger]="新規投稿に失敗しました"
      render :new
    end
  end

  def index
    @posts=Post.order(created_at: :desc)
  end

  def show
    @post=Post.find(params[:id])
    @comment=Comment.new #コメント新規作成用
    #@comments=@post.comments　#コメント一覧表示用
  end

  def edit
    @post=Post.find(params[:id])
  end

  def update
    @post=Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, success: "投稿を編集しました"
    else
      flash.now[:danger]="投稿の編集に失敗しました"
      render :edit
    end
  end

  def destroy
    Post.find(params[:id]).delete
    redirect_to posts_path, success: "投稿を削除しました。"
  end

  private
    def post_params
      params.require(:post).permit(:title, :post_tag_id, :image, :content,)
    end
end
