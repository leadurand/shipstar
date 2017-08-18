Rails.application.routes.draw do

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  resources :ships, only: [:index, :show], shallow: true do
    resources :bookings, only: [:show, :destroy, :create]
  end
  resources :bookings, only: [:index]
  resources :users, only: [:show], shallow: true do
    get 'ships', to: 'ships#my_ships'
    resources :ships, only: [:new, :create]
  end
  patch 'bookings/:id', to: 'bookings#update', as: "booking_update"
  put 'bookings/:id', to: 'bookings#update'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
