Rails.application.routes.draw do
  root 'feeds#index'
  resources :contacts
  resources :feeds do
    collection do
      post :confirm
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :favorites, only: [:create, :destroy, :index]
  # ↓試験環境では「if Rails.env.development?」を末尾に追加する
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end