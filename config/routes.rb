Rails.application.routes.draw do
  get '/' => 'items#new'
  get '/index' => 'items#index'
  get 'about' => 'items#about'
  post 'items' => 'items#create'
  delete 'items/:id' => 'items#destroy'
  resources :items do
    collection do 
      get 'search'
    end
  end
end