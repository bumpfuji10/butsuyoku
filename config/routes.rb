Rails.application.routes.draw do
  get 'users/new'
  get 'sessions/new'
  get '/' => 'items#home'
  get '/index' => 'items#index'
  get 'about' => 'items#about'
  post 'items' => 'items#create'
  delete 'items/:id' => 'items#destroy'
  patch 'items/:id' => 'items#update'

  get '/signup' => 'users#new'
  get '/users/:id' => 'users#show'
  patch 'users/:id' => 'users#update'
  resources :users

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :items do
    collection do
      get 'search'
    end
  end
end
