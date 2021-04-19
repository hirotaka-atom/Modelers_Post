class SearchController < ApplicationController
  before_action :set_post_search_query

  def index
    @results = @q.result(distinct: true).page(params[:page]).per(10).order(created_at: :desc)
  end
end
