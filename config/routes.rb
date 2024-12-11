Rails.application.routes.draw do
  resources :videos
  # Define CRUD paths for Articles
  resources :articles

  # Admin routes for managing articles
  namespace :admin do
    resources :articles do
      member do
        post :submit_for_review
        post :approve
        post :reject
      end
    end
    resources :videos

  end

  # Defines the root path route ("/")
  root "admin/articles#index"
end
