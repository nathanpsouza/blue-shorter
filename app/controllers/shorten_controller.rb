class ShortenController < ApplicationController
  def create
    short_url = ShortUrl.new(url: short_url_params[:url])
    if short_url.save
      url = redirect_to_short_url(short_url.encoded_id)
      render json: { short_url: url }, status: :created
    else
      render json: { errors: short_url.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def short_url_params
    json = JSON.parse(request.body.read)
    ActionController::Parameters
                      .new(json)
                      .require(:short_url)
                      .permit(:url)
  end
end
