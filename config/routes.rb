Rails.application.routes.draw do
  devise_for :users
  root to: 'categories#index' # Categories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :categories, only: [:index, :new, :create, :show]
  resources :masters, only: [:index, :show, :new, :create, :edit, :update] do
    resources :orders, only: [:show, :new, :create] do
      resources :reviews, only: [:new, :create, :show]
    end
  end
  resources :users, only: :show
end
