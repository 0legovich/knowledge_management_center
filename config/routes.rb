Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'users/registrations'}
  devise_scope :user do
    authenticated :user do
      root :to => 'users#show'
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new'
    end
  end

  resources :users
  post '/user/create' => 'users#create', :as => :create_user
  resources :organizations
  resources :divisions
end
