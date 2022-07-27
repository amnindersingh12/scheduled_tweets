Rails.application.routes.draw do
  devise_for :users

  # Home page
  root to: "tweets#index"

  # create a tweet page
  get "tweet/new", to: "tweets#new"
  post "tweet/new", to: "tweets#create"

  # show all tweets page
  get "tweet/all", to: "tweets#index"
  get "tweet/:id", to: "tweets#show", as: :tweet

  # delete tweet
  delete "tweet/:id", to: "tweets#destroy"

  # add profile
  resources :profiles

  # add likes
  resources :likes

  # add followers
  post "profiles/follow", to: "profiles#follow"
  delete "profiles/", to: "profiles#unfollow"

  # list follower and following
  get "profiles/:id/follower", to: "profiles#follower", as: :follower
end
