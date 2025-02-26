Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :users
  end
  resources :alcohol_logs
  resources :paid_leaves do
    collection do
      # resources :request, only: [:create, :new]
      resources :approval, only: [:create, :new, :edit, :update]
    end
  end
  devise_scope :user do
    root to: 'devise/sessions#new'
  end
  # root to: 'paid_leaves#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
