class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :http_status_not_found

  def http_status_not_found
    render '', status: :not_found
  end
end
