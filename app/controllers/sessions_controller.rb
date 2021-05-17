class SessionsController < ApplicationController
  before_action :set_post_search_query
  before_action :forbid_login_user, except: [:destroy]

  def new
  end

  def create
    user = User.find_by(email_params)
    if user && user.authenticate(password_params[:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to root_url, success: "ログインに成功しました"
      else
        message  = "アカウントが有効化されていません。"
        message += "メールを確認し、有効化を行ってください。"
        flash[:warning] = message
        redirect_to login_path
      end
    else
      flash.now[:danger] = "メールアドレスまたはパスワードが間違っています"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, info: "ログアウトしました"
  end

  private
  
    def email_params
      params.require(:session).permit(:email)
    end

    def password_params
      params.require(:session).permit(:password)
    end

    def log_in(user)
      session[:user_id] = user.id
    end

    def forget(user)
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
    end

    def log_out
      forget(current_user)
      session.delete(:user_id)
      @current_user = nil
    end

    def remember(user)
      user.remember
      cookies.permanent.signed[:user_id] = user.id
      cookies.permanent[:remember_token] = user.remember_token
    end
end
