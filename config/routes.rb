Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks do  
    collection do
      post :confirm
    end
  end

  resources :users, only: [:new, :create, :index, :show]
  end    

