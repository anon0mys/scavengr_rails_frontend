Rails.application.routes.draw do
  root to: 'home#index'

  get '/create_account', to: 'users#new', as: 'create_account'
  get '/login', to: 'sessions#new', as: 'login'
  delete '/logout', to: 'sessions#destroy', as: 'logout'
  post '/login', to: 'sessions#create'

  resources :users, only: %i[create]

  resources :scavenger_hunts, only: %i[index new create]
end
