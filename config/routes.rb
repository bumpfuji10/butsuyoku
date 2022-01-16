Rails.application.routes.draw do
  get '/' => 'items#new'
  get 'items/index' => 'items#index'
  post 'items' => 'items#create'
  delete 'items/:id' => 'items#destroy'
end