Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root 'pages#top'
  get 'pages/about'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get 'search/index'

  resources :users do
    member do
      get :followings, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :events
  resources :post_tags
  resources :bravo_tags

  resources :posts do
    resources :comments
    resources :bravos
  end

  resources :favorites
  resources :relationships, only: [:create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
