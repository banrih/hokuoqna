Rails.application.routes.draw do
  get 'likes/create'

  get 'likes/destroy'

  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create]
  resources :posts, only: [:show, :new, :create, :destroy]
  resources :likes, only: [:create, :destroy]
end
