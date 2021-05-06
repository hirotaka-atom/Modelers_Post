class UsersController < ApplicationController
  before_action :set_post_search_query
  before_action :authenticate_user, except: [:new, :create, :show]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_admin, only: [:index]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, success: "登録が完了しました"
    else
      render :new
    end
  end

  def index
    @users = User.page(params[:page]).per(20).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: params[:id]).page(params[:page]).per(10)
    @bravo_posts = @user.bravo_posts.page(params[:page]).per(10)
    @favorite_posts = @user.favorite_posts.page(params[:page]).per(10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, success: "情報を編集しました"
    else
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to root_path, success: "ユーザーを削除しました"
  end

  private
    def user_params
      params.require(:user).permit(:name, :image, :email, :password, :password_confirmation, :admin)
    end
end
