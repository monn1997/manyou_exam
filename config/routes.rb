Rails.application.routes.draw do
  get '/tasks', to: 'tasks#index' 
  resources :tasks
end
