Rails.application.routes.draw do

  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, except: [:index]
  resources :definitions
  
  resources :definitions do
    resource :user_definitions, only: [:new, :create]
  end
  
  resources  :user_definitions, except: [:new, :create]
  
end
