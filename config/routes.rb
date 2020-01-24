Rails.application.routes.draw do
  root to: 'posts#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:index, :show] do
    member do
      post :send_friend_request
      post :cancel_friend_request
      post :accept_friend_request
      post :reject_friend_request
      post :delete_friend
    end
  end

  resources :posts, only: [:index, :show, :create] do
    member do
      post :like
      post :dislike
      post :comment
    end
  end
end
