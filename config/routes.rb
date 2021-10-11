Rails.application.routes.draw do
  # get '/articles', to: 'aticles#index'
  resources :articles, only: [:index] #creates all crud routes at once limited by only
end
