class PostsController < ApplicationController
  impressionist :action=> [:show], unique: [:impressionable_id, :ip_address]
  before_action :set_post_search_query
  before_action :authenticate_user, except: [:index, :show]
  before_action :ensure_correct_post, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to posts_path, success: "新規投稿しました"
    else
      render :new
    end
  end

  def index
    @posts = Post.page(params[:page]).per(10).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @bravo_tags=BravoTag.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, success: "投稿を編集しました"
    else
      render :edit
    end
  end

  def destroy
    Post.find(params[:id]).delete
    redirect_to posts_path, success: "投稿を削除しました"
  end

  private
    def post_params
      params.require(:post).permit(:title, :image, :content, :post_tag_id)
    end
end
