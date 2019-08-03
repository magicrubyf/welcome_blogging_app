Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'

  get '/auth/:provider/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  
end
