class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  before_action :set_post_search_query
  before_action :forbid_login_user

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      redirect_to root_url, info: "メールを送信しました。メールを確認し、パスワードを変更してください。"
    else
      flash.now[:danger] = "メールアドレスが見つかりませんでした"
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update(user_params)
      log_in @user
      @user.update(reset_digest: nil)
      redirect_to @user, success: "パスワードのリセットが完了しました"
    else
      render 'edit'
    end
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  private

    def get_user
      @user = User.find_by(email: params[:email])
    end

    def valid_user
      unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "アドレスが期限切れです"
        redirect_to new_password_reset_url
      end
    end

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
