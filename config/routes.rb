Rails.application.routes.draw do
  get 'organizations/all'

  devise_for :users, controllers: {registrations: 'users/registrations'}
  root 'users#show'

  resources :users, only: [:index, :show]
  resources :organizations
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
