Rails.application.routes.draw do

  namespace :preview do
    resources :contact, only: [:index]
  end

  resources :preview, only: [:index]

  root 'home#index'

end
