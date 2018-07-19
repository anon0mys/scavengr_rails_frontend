Rails.application.routes.draw do
  root to: 'home#index'

  get '/create_account', to: 'users#new', as: 'create_account'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'

  resources :users, only: %i[create]
end
