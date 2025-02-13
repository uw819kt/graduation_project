Rails.application.routes.draw do
  resources :users
  resources :alcohol_logs
  resources :paid_leaves
  root to: 'paid_leaves#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
