Rails.application.routes.draw do
  root 'pages#top'
  get 'pages/about'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :users
  #resources :posts
  #resources :comments
  resources :events
  resources :post_tags
  resources :bravo_tags

  resources :posts do
    resources :comments
  end

  get 'bravos/index'
  post '/bravos', to: 'bravos#create'
  delete '/unbravos', to: 'bravos#destroy'

  get 'favorites/index'
  post '/favorites', to: 'favorites#create'
  delete '/unfavorites', to: 'favorites#destroy'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
