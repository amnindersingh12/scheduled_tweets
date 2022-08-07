Rails.application.routes.draw do
  devise_for :users

  # Home page
  root to: "tweets#index"

  resources :tweets, except: [:edit, :update] do
    resources :comments # tweets/:id/comments
    member do
      post :retweet # tweets/:id/retweet
    end
  end

  # create a tweet page
  # get "tweet/new", to: "tweets#new"
  # post "tweet/new", to: "tweets#create"

  # # show all tweets page
  # get "tweet/all", to: "tweets#index"
  # get "tweet/:id", to: "tweets#show", as: :tweet

  # # delete tweet
  # delete "tweet/:id", to: "tweets#destroy"

  # add profile
  resources :profiles

  # add likes
  resources :likes # tweets/:id/likes



  # add followers
  post "profiles/follow", to: "profiles#follow" 
  delete "profiles/", to: "profiles#unfollow"

  # list follower and following
  get "profiles/:id/follower", to: "profiles#follower", as: :follower

  # add comments
  # get "tweet/:id/comment", to: "tweets#comment"
  # delete "profiles/", to: "profiles#unfollow"
# resources :comments

end
