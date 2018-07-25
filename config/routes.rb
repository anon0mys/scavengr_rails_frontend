Rails.application.routes.draw do
  get 'hello_world', to: 'hello_world#index'
  root to: 'home#index'

  get '/create_account', to: 'users#new', as: 'create_account'
  get '/login', to: 'sessions#new', as: 'login'
  delete '/logout', to: 'sessions#destroy', as: 'logout'
  post '/login', to: 'sessions#create'

  get '/maps/:id', to: 'maps#show', as: 'map'

  resources :users, only: %i[create]

  resources :scavenger_hunts
end
