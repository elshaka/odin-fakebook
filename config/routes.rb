Rails.application.routes.draw do
  root to: 'posts#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }
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

  get '/notifications', to: 'notifications#index'
  post '/notifications/:id/mark_as_read', to: 'notifications#mark_as_read', as: 'mark_as_read_notification'
  post '/notifications/mark_all_as_read', to: 'notifications#mark_all_as_read', as: 'mark_all_as_read_notifications'
end
