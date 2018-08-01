Rails.application.routes.draw do
  root to: 'home#index'

  get '/create_account', to: 'users#new', as: 'create_account'
  delete '/logout', to: 'sessions#destroy', as: 'logout'
  post '/login', to: 'sessions#create'

  get '/maps/:id', to: 'maps#show', as: 'map'

  resources :users, only: %i[create]

  resources :current_scavenger_hunts, only: %i[index]

  resources :scavenger_hunts do
    resources :points, only: %i[new create update]
  end

  resources :user_points, only: %i[update]


  get '/:username/scavenger_hunts', to: 'user_scavenger_hunts#index', as: 'user_scavenger_hunts'
  get '/:username/scavenger_hunts/:id', to: 'user_scavenger_hunts#show', as: 'user_scavenger_hunt'

  get '*unmatched_route', to: 'application#not_found'
end
