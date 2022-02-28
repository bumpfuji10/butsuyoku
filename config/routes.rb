Rails.application.routes.draw do
  get 'users/new'
  get 'sessions/new'
  get '/' => 'items#new'
  get '/index' => 'items#index'
  get 'about' => 'items#about'
  post 'items' => 'items#create'
  delete 'items/:id' => 'items#destroy'
  patch 'items/:id' => 'items#update'
  get 'item/:id' => 'items#show'

  get '/signup' => 'users#new'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :items do
    collection do
      get 'search'
    end
  end
end
