Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home' # Categories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :categories do
    resources :masters do
      resources :orders
      resources :reviews
    end
  end
  resources :users, only: :show
end
