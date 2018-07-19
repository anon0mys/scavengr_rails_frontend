Rails.application.routes.draw do
  root to: 'home#index'

  get '/create_account', to: 'users#new', as: 'create_account'

  resources :users, only: %i[create]
end
