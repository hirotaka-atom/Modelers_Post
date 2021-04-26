Rails.application.routes.draw do
  root 'pages#top'
  get 'pages/about'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get 'search/index'

  resources :users
  resources :events
  resources :post_tags
  resources :bravo_tags

  resources :posts do
    resources :comments
    resources :bravos
  end

  resources :favorites


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
