Rails.application.routes.draw do
  resources :feeds
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :favorites, only: [:create, :destroy]
end