class UsersController < ApplicationController
  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    #@user.image="default_icon.jpg"
    if @user.save
      redirect_to root_path,  success: "登録が完了しました"
    else
      flash.now[:danger]="登録に失敗しました"
      render :new
    end
  end

  def index
    @users=User.all.order(created_at: :desc)
  end

  def show
    @user=User.find(params[:id])
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, success: "情報を編集しました"
    else
      flash.now[:danger]="情報の編集に失敗しました"
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
