class RedirectsController < ApplicationController
  def show
    short_url = ShortUrl.find_by!(encoded_id: params[:id])
    short_url.increment_visits_counter!
    redirect_to short_url.url, status: :found
  end
end
