Rails.application.routes.draw do


  #home
  root 'home#index'
  get 'home/index'

  #auth & sessions
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  #users
  get 'users',to: 'users#index'
  get 'users/:id/posts', to: 'users#show'

  #posts
  resources :posts


end
