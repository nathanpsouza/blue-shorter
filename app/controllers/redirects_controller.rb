class RedirectsController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def show
    @short_url = ShortUrl.find_by!(encoded_id: params[:id])
    @short_url.increment_visits_counter!
  end

  private

  def render_not_found
    render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
  end
end
