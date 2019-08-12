Rails.application.routes.draw do
  resources :shorten, only: :create
  namespace :urls do
    resources :top_visits, only: :index
  end
  get '/:id' => 'redirects#show', as: :redirect_to_short
end
