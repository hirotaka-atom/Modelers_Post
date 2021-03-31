Rails.application.routes.draw do
  root 'pages#top'
  get 'pages/about'
  get 'sessions/new'

  resources :users
  resources :posts
  resources :comments
  resources :events
  resources :post_tags
  resources :bravo_tags


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
