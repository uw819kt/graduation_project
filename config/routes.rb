Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  namespace :admin do
    resources :users
  end
  resources :alcohol_logs, only: [:index, :show, :new, :create, :edit, :update]
  resources :paid_leaves, only: [:index, :show] do
    collection do
      # resources :request, only: [:create, :new]
      resources :approval, only: [:create, :new, :edit, :update]
    end
  end
  devise_scope :user do
    get 'users/guest_sign_in', to: 'users/sessions#guest_sign_in', as: 'guest_sign_in'
    get 'admin_guest_sign_in', to: 'users/sessions#admin_guest_sign_in', as: 'admin_guest_sign_in'

  end

  root to: 'paid_leaves#index'

 
  # root to: 'paid_leaves#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
