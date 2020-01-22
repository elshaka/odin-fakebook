Rails.application.routes.draw do
  root to: 'static_pages#home'

  devise_for :users
  resources :posts, only: [:index, :show]
  resources :users, only: [:index, :show]
end
