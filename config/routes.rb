Rails.application.routes.draw do
  devise_for :users

  root to: 'tweets#index'

  resources :tweets, except: %i[edit update] do
    member do
      post :retweet
      get :retweeters
      post :reply
    end
  end

  resources :profiles

  resources :likes

  post 'profiles/follow', to: 'profiles#follow'
  delete 'profiles/', to: 'profiles#unfollow'

  get 'profiles/:id/follower', to: 'profiles#follower', as: :follower

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end
end
