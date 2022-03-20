Rails.application.routes.draw do
  resources :contacts
  resources :feeds
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :favorites, only: [:create, :destroy]
end