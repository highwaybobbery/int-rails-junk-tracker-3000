Rails.application.routes.draw do
  resources :vehicles
  root "vehicles#index"
end
