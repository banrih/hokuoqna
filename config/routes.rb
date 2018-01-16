Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  resources :users, only: [:show, :new, :create] do
    member do
      get :like_posts
    end
  end
  
  resources :posts, only: [:show, :new, :create, :destroy] do
    resources :comments, only: [:new, :create, :destroy]
  end
  
  resources :likes, only: [:create, :destroy]
  
  get 'rankings/like', to: 'rankings#like'
end
