Rails.application.routes.draw do

  # You can have the root of your site routed with "root"
  root 'home#index'

  resources :users
  resources :sessions, only: [:create, :destroy] 

  with_options controller: :documents, except: [ :show ]  do 
    resources :articles
    resources :letters
    resources :reports
  end

end
