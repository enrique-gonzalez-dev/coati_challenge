Rails.application.routes.draw do
  resources :tickets
  resources :sellers
  resources :products
  resources :clients
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root 'pages#dashboard'

  get 'import' => 'tickets#import'
  post 'import' => 'tickets#read_import'

end
