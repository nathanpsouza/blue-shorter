class Urls::TopVisitsController < ApplicationController
  def index
    limit = params[:limit] ? params[:limit] : 100
    urls = ShortUrl.order(visits_counter: :desc ).limit(limit)
    render json: urls, methods: :short_url, status: :ok
  end
end
