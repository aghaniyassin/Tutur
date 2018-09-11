Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
  resource :users, only: [:new, :create]
  resource :sessions, only: [:destroy, :create, :new]
  resource :user, only: [:edit, :update] do
    resources :cars, only: [:index], controller: 'users/cars'
    resources :rentals, only: [:index, :update, :show], controller: 'users/rentals'
  end
  resources :cars, only: [:new, :create, :show, :edit, :update, :index] do
    resources :rentals, only: [:new, :create]
  end
  resources :rentals, only: [:show, :index]
end
