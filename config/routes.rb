Rails.application.routes.draw do
  devise_for :users

  root to: 'tweets#index'

  resources :tweets, except: %i[edit] do
    member do
      post :retweet
      post :quote
      get  :new_quote
      get  :visitor
      post :reply
      post :like
      get :likes
    end
  end

  resources :profiles do
    member do
      post :follow
      get :follower
      delete :unfollow
    end
  end

  resources :notifications
  #   collection do
  #     post :mark_as_read
  #   end
  # end
end
