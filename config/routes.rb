Rails.application.routes.draw do
  get '/' => 'items#new'
  get '/index' => 'items#index'
  post 'items' => 'items#create'
  delete 'items/:id' => 'items#destroy'
  get 'search/:id' => 'items#search'
end