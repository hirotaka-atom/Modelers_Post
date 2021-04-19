class EventsController < ApplicationController
  before_action :set_post_search_query
  
  def new
  end

  def create
  end

  def index
    #agent = Mechanize.new
    #page = agent.get("http://plamo.kitasite.net/event/")
    #@elements = page.search('.entry-content a')
    @events=Event.order(created_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
