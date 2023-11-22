Rails.application.routes.draw do
  get 'search/index', to: 'search#index '
  
  get 'users/profile'
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get '/u/:id', to: 'users#profile', as: 'user'

  root "articles#index"
  
  resources :articles

  resources :articles do
    resources :comments
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
