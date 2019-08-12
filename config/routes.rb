Rails.application.routes.draw do
  resources :shorten, only: :create
  get '/:id' => 'redirects#show', as: :redirect_to_short
end
