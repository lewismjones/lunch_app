Rails.application.routes.draw do
  get 'home/index'

  resources :restaurants

  get 'surveys/new'
  post 'surveys/new', to: 'surveys#create'
  get 'surveys/results'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root 'home#index'
end
