

Rails.application.routes.draw do
  
  #  About page
  get "about", to: "about#index" 
  
  # Sign up page
  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  # Sign in page
  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  
  # Home page
  root to: "main#index"

  # Logout 
  delete "logout", to: "sessions#destroy"


end
