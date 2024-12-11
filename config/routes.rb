Rails.application.routes.draw do
  resources :videos
  # Define CRUD paths for Articles
  resources :articles

  # Admin routes for managing articles
  namespace :admin do
    resources :articles
    resources :videos
  end

  # Defines the root path route ("/")
  root "admin/articles#index"
end
