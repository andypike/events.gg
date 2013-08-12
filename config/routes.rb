Events::Application.routes.draw do
  root 'home#index'

  get 'signup', to: 'users#new', as: :signup
  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout
  get 'settings', to: 'users#edit', as: :settings

  resources :users
  resources :sessions

  namespace :admin do
    get '', to: 'dashboard#index', as: '/'
    
    resources :users
  end
end
