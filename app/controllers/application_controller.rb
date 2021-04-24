class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :info, :warning, :danger

  helper_method :current_user, :logged_in?

  def set_post_search_query
    #if params[:q].present?
      #params[:q] == params[:q][:user_name_or_post_tag_name_or_title_or_content_cont].split(/[\p{blank}\s]+/)
    #end
    @q = Post.ransack(params[:q])
    @results = @q.result(distinct: true)
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end
end
