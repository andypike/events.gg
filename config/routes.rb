Events::Application.routes.draw do
  root 'home#index'

  get 'signup', to: 'users#new', as: :signup
  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout

  resources :users
  resources :sessions
end
