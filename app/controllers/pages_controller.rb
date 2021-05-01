class PagesController < ApplicationController
  before_action :set_post_search_query

  def top
    @posts = Post.page(params[:page]).per(30).order(created_at: :desc)
    @rankings = Post.includes(:bravo_users).sort {|a, b| (b.bravo_users.count <=> a.bravo_users.count).nonzero? || (b.impressions_count <=> a.impressions_count)}.take(10)
    @unlikes = Post.includes(:bravo_users).sort {|a, b| (a.bravo_users.count <=> b.bravo_users.count).nonzero? || (a.impressions_count <=> b.impressions_count)}.take(30)
  end

  def about
  end
end
