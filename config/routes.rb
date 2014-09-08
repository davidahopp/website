Rails.application.routes.draw do

  resources :contact, only: [:index]
  resources :home, only: [:index]

  root 'home#index'

end
