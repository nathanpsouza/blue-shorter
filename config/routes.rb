Rails.application.routes.draw do
  get '/:id' => 'redirects#show'
end
