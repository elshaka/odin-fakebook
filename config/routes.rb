Rails.application.routes.draw do
  root to: 'posts#index'

  devise_for :users
  resources :users, only: [:index, :show]

  resources :posts, only: [:index, :show, :create] do
    member do
      post :like
      post :dislike
      post :comment
    end
  end
end
