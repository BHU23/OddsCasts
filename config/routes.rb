Rails.application.routes.draw do
  # Define CRUD paths for Articles
  resources :articles

  # Health check path
  get "up" => "rails/health#show", as: :rails_health_check

  # Custom admin routes
  get "/admin/new", to: "admin#new", as: :new_admin
  get "/admin/edit", to: "admin#edit", as: :edit_admin

  # Defines the root path route ("/")
  root "articles#index" # Set articles#index as the root route
end
