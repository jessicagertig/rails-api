Rails.application.routes.draw do
  # get '/articles', to: 'articles#index'
  resources :articles, only: [:index, :show] #creates all crud routes at once limited by only
end
