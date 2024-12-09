Rails.application.routes.draw do
  resources :videos
  # Define CRUD paths for Articles
  resources :articles

  # Admin routes for managing articles
  namespace :admin do
    resources :articles
    root "admin/articles#index"
    resources :videos
  end
  get "admin/index"

  # Defines the root path route ("/")
  root "articles#index"
end
