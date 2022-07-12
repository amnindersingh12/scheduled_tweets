

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
  
  # Home page
  root to: "main#index"

  # Logout 
  delete "logout", to: "sessions#destroy"


end
