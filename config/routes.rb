Rails.application.routes.draw do
  # Define CRUD paths for Articles
  resources :articles

  # Admin routes for managing articles
  namespace :admin do
    resources :articles
  end

  # Defines the root path route ("/")
  root "articles#index"
end
