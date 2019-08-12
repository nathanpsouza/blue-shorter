class GetWebsiteTitleWorker
  include Sidekiq::Worker

  def perform(short_url_id)
    short_url = ShortUrl.find(short_url_id)
    mechanize = Mechanize.new
    begin
      page = mechanize.get(short_url.url)
      if page.respond_to? :title
        short_url.title = page.title
        short_url.save
      end
    rescue SocketError
      return
    end
  end
end
