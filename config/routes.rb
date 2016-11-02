Rails.application.routes.draw do

  get "static_pages/*page", to: "static_pages#show"

  root "static_pages#show", page: "home"

  get "/signup", to: "users#new"

  post "/signup", to: "users#create"

end
