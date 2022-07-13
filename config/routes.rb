

Rails.application.routes.draw do
 
  #  About page
  get "about", to: "about#index" 
  
  # Sign up page
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  # Sign in page
  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  # edit password page
  get "password", to: "passwords#edit"
  patch "password", to: "passwords#update"

  # Password Reset page
  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"
 
  # Password Reset edit and update page

  get "password/reset/edit", to: "password_resets#edit"
  patch "password/reset/edit", to: "password_resets#update"
  
  # Home page
  root to: "main#index"

  # Logout 
  delete "logout", to: "sessions#destroy"

  # create a tweet page 
  get "tweet/new", to: "tweets#new"
  post "tweet/new", to: "tweets#create"

  # show all tweets page
  get "tweet/all", to: "tweets#index"
  get "tweet/:id", to: "tweets#show", as: :tweet
end
