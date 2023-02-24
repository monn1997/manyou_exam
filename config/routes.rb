Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks do  
    collection do
      post :confirm
    end
  end

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  namespace :admin do
    resources :users
  end  
end    

