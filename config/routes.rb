Rails.application.routes.draw do
  devise_for :users
  root to: 'categories#index' # Categories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :categories, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :masters, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :orders, only: [:show, :new, :create, :edit, :update, :destroy] do
      resources :reviews, only: [:new, :create, :show, :destroy]
    end
  end
  resources :users, only: [:show]
  get 'about', to: 'pages#about'
end
