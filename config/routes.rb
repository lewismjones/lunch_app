Rails.application.routes.draw do
  get 'home', to: 'home#home'
  get 'admin', to: 'home#admin'

  resources :restaurants
  resources :surveys, only: [:show, :index, :destroy, :new, :create]

  get 'survey/results', to: 'surveys#results'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root 'home#home'
end
