class PagesController < ApplicationController
  before_action :set_post_search_query

  def top
    @posts = Post.page(params[:page]).per(30).order(created_at: :desc)
    #@rankings = Post.includes(:bravo_users).where(created_at: Date.current)
    #@rankings = Bravo.includes(:post).where("created_at like ?", "%#{Date.current}%").sort {|a, b| (b.post.bravo_users.count <=> a.post.bravo_users.count).nonzero? || (b.post.impressions_count <=> a.post.impressions_count)}.take(10)
    #binding.pry
    #@rankings = Post.joins(:bravos).where("bravos.created_at like ?", "%#{Date.current}%").distinct.sort {|a, b| (b.bravo_users.count <=> a.bravo_users.count).nonzero? || (b.impressions_count <=> a.impressions_count)}.take(10)
    @rankings = Post.joins(:bravos).where(bravos: {created_at: Date.current.in_time_zone.all_day}).distinct.sort {|a, b| (b.bravo_users.count <=> a.bravo_users.count).nonzero? || (b.impressions_count <=> a.impressions_count)}.take(10)
    @unlikes = Post.includes(:bravo_users).sort {|a, b| (a.bravo_users.count <=> b.bravo_users.count).nonzero? || (a.impressions_count <=> b.impressions_count)}.take(30)
  end

  def about
  end
end
