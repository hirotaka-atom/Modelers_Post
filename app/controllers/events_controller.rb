class EventsController < ApplicationController

  def new
  end

  def create
  end

  def index
    agent = Mechanize.new
    page = agent.get("http://plamo.kitasite.net/event/")
    @elements = page.search('.entry-content a')
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
