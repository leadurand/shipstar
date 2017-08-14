Rails.application.routes.draw do
  root to: 'pages#home'
  resources :ships, only: [:index, :show], shallow: true do
    resources :bookings, only: [:show, :destroy, :create]
  end
  resources :bookings, only: [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end