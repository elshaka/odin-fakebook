Rails.application.routes.draw do
  root to: 'posts#index'

  devise_for :users
  resources :posts, only: [:index, :show, :create]
  resources :users, only: [:index, :show]
end
