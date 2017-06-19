Rails.application.routes.draw do

  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create]
  resources :definitions
  
  resources :definitions do
    resource :user_definitions, only: [:new, :create]
  end
  #definition_idを入れる書き方#
  
  resources  :user_definitions, except: [:new, :create]
  
end
