Rails.application.routes.draw do
  root to: 'home#index'

  get '/create_account', to: 'users#new', as: 'create_account'
  delete '/logout', to: 'sessions#destroy', as: 'logout'
  post '/login', to: 'sessions#create'

  get '/maps/:id', to: 'maps#show', as: 'map'

  resources :users, only: %i[create]

  resources :current_scavenger_hunts, only: %i[index destroy]

  resources :scavenger_hunts do
    resources :points, only: %i[new create update destroy]
  end

  delete '/scavenger_hunt_points/:scavenger_hunt_id', to: 'scavenger_hunt_points#destroy', as: 'all_scavenger_hunt_points'

  resources :user_points, only: %i[update]


  get '/:username/scavenger_hunts', to: 'user_scavenger_hunts#index', as: 'user_scavenger_hunts'
  get '/:username/scavenger_hunts/:id', to: 'user_scavenger_hunts#show', as: 'user_scavenger_hunt'

  get '*unmatched_route', to: 'application#not_found'
end
