Rails.application.routes.draw do

  get 'ownerships/create'

  get 'ownerships/destroy'

  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, except: [:index] do
    member do
      get :constitution, :civil_code, :criminal_code, :civil_procedure_law, :notebook
    end
  end

  resources :definitions do
    resource :user_definitions, only: [:new, :create]
    collection do
      post :import
    end
  end
  
  resources  :user_definitions, except: [:new, :create]
  
  resources :ownerships, only: [:create, :destroy]
  
  get 'tests/start', to: 'tests#start', as: 'tests_start'
  get 'tests/question', to: 'tests#question', as: "tests_question"
  post 'tests/answer', to: 'tests#post_answer'
  get 'tests/answer', to: 'tests#get_answer'
  get 'tests/result', to: 'tests#result', as: 'tests_result'
end
