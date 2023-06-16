Rails.application.routes.draw do
  root "static_pages#home"

  get "/help",        to: "static_pages#help",     as: "help"
  get "/about",       to: "static_pages#about",    as: "about"
  get "/contact",     to: "static_pages#contact",  as: "contact"
  get "/signup",      to: "users#new",             as: "signup"           

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

  get "/login",       to: "sessions#new"
  post "/login",      to: "sessions#create"
  delete "/logout",   to: "sessions#destroy",      as: "logout"
end
