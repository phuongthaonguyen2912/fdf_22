Rails.application.routes.draw do

  get "static_pages/*page", to: "static_pages#show"
  root "static_pages#show", page: "home"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users, except: [:index, :destroy]
  resources :products, only: [:index, :show] do
    resources :comments, only: [:create, :destroy, :new]
  end
  namespace :admin do
    resources :users, only: [:index, :destroy]
    resources :categories, except: :show
    resources :products, except: :show
  end
  resources :product_suggests, except: :show
end
