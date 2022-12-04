Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end



  root to: 'items#home'
  get 'users/new'
  get 'sessions/new'
  get '/' => 'items#home'
  get 'items/new' => 'items/new'
  get '/index' => 'items#index'
  get 'about' => 'items#about'
  post 'items' => 'items#create'
  delete 'items/:id' => 'items#destroy'
  get 'items/:id/edit' => 'items#edit'
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
