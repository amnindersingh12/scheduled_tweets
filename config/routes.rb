Rails.application.routes.draw do
  devise_for :users

  root to: 'tweets#index'

  resources :tweets, except: %i[edit update] do
    member do
      post :retweet
      get  :visitors, as: :visitor
      post :reply
      post :like
      get :show_likes
    end
  end

  resources :profiles

  # likes
  # post 'like/:id', to: 'tweets#like', as: :like
  # get 'like/:id', to: 'tweets#like_index'

  # visitor counts
  # get 'visitor/:id', to: 'tweets#visitors', as: :visitor

  # follow unfollow
  post 'profiles/follow', to: 'profiles#follow'
  delete 'profiles/', to: 'profiles#unfollow'

  # list of followers
  get 'profiles/:id/follower', to: 'profiles#follower', as: :follower

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end
end
