Rails.application.routes.draw do


  get 'password_resets/new'

  get 'password_resets/edit'

  get 'users/download_pdf'
  get 'users/download_scorecard'

  root 'landing_pages#home'
  get  'landing_pages/about',   to: 'landing_pages#about'
  get  'landing_pages/help',    to: 'landing_pages#help'
  get  'landing_pages/privacy', to: 'landing_pages#privacy'
  get  'landing_pages/family_portrait', to: 'landing_pages#family_portrait'
  
  get  '/signup',     to: 'users#new'
  post '/signup',     to: 'users#create'
  get    '/login',    to: 'sessions#new'
  post   '/login',    to: 'sessions#create'
  delete '/logout',   to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:new, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
