class SearchController < ApplicationController
  before_action :set_post_search_query

  def index
    @results = @results.page(params[:page]).per(10).order(created_at: :desc)
  end
end
