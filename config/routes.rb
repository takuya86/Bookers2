Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get "homes/about", to: "homes#about", as: "about"
  resources :users, only: [:show, :edit, :update]
  resources :books, only: [:new, :create, :index, :show, :destroy]
end
