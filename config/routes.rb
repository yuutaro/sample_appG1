Rails.application.routes.draw do
  root "static_pages#home"

  get "/help",        to: "static_pages#help",     as: "help"
  get "/about",       to: "static_pages#about",    as: "about"
  get "/contact",     to: "static_pages#contact",  as: "contact"
  get "/signup",      to: "users#new",             as: "signup"           

  resources :users do
    member do
      get :following, :followers
      # GET /users/1/following
      # GET /users/1/followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]

  get "/login",       to: "sessions#new"
  post "/login",      to: "sessions#create"
  delete "/logout",   to: "sessions#destroy",      as: "logout"

  get "/microposts",  to: "static_pages#home"
end
