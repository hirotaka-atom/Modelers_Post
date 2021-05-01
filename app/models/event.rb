class Event < ApplicationRecord
  validates :name, presence: true
  validates :url, presence: true

  def self.scrape
    agent = Mechanize.new
    page = agent.get("http://plamo.kitasite.net/event/")
    #elements = page.search('//*[@id="post-1797"]/div/a[1]')
    elements = page.search('.entry-content a')
    for i in 5..20
      if i != 9 && i != 10 && i != 12 && i != 13 && i != 14 && i != 15 && i != 19
        event = Event.new
        event.name = elements[i].inner_text
        event.url = elements[i][:href]
        event.save
      end
    end
  end

end
