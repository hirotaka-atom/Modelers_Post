class AccountActivationsController < ApplicationController
  before_action :set_post_search_query

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "アカウントの有効化が完了しました"
      redirect_to user
    else
      flash[:danger] = "アドレスが無効です"
      redirect_to root_url
    end
  end

  def log_in(user)
    session[:user_id] = user.id
  end
end
