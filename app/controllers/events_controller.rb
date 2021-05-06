class EventsController < ApplicationController
    before_action :set_post_search_query
    before_action :authenticate_admin, except: [:index]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to events_path, success: "イベントを作成しました"
    else
      render :new
    end
  end

  def index
    agent = Mechanize.new
    page = agent.get("http://plamo.kitasite.net/event/")
    @elements = page.search('//*[@id="post-1797"]/div/a')
    @elements = page.search('.entry-content a')
    @events = Event.page(params[:page]).per(10).order(created_at: :desc)
  end

  def edit
    @event=Event.find(params[:id])
  end

  def update
    @event=Event.find(params[:id])
    if @event.update(event_params)
      redirect_to events_path, success: "イベント情報を編集しました"
    else
      render :edit
    end
  end

  def destroy
    Event.find(params[:id]).delete
    redirect_to events_path, success: "いいね用タグを削除しました"
  end

  private
    def event_params
      params.require(:event).permit(:name, :url)
    end
end
