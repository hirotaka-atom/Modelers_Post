class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :info, :warning, :danger

  helper_method :current_user, :logged_in?

  def set_post_search_query
    if params[:q] != nil
      key_words= params[:q][:user_name_or_post_tag_name_or_title_or_content_cont].split(/[\p{blank}\s]+/)
      grouping_hash = key_words.reduce({}){|hash, word| hash.merge(word => { user_name_or_post_tag_name_or_title_or_content_cont: word})}
      @q = Post.ransack({ combinator: 'and', groupings: grouping_hash })
    else
      @q = Post.ransack(params[:q])
    end
    @results = @q.result(distinct: true)
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def authenticate_user
    if session[:user_id ]== nil
      redirect_to login_path, danger: "ログインが必要です"
    end
  end

  def forbid_login_user
    if session[:user_id]
      redirect_to root_path, danger: "すでにログインしています"
    end
  end

  def ensure_correct_user
    if current_user.id != params[:id].to_i
      redirect_to current_user, danger: "権限がありません"
    end
  end

  def ensure_correct_post
    @post = Post.find(params[:id])
    if current_user.id != @post.user_id
      redirect_to posts_path, danger: "権限がありません"
    end
  end

  def ensure_correct_comment
    @comment = Comment.find(params[:id])
    if current_user.id != @comment.user_id
      redirect_to post_comments_path, danger: "権限がありません"
    end
  end

  def authenticate_admin
    if !current_user.present? || !current_user.admin?
      redirect_to root_path, danger: "権限がありません"
    end
  end
end
