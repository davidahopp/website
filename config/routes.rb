Rails.application.routes.draw do

  resources :preview, only: [:index]

  root 'home#index'

end
