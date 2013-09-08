Myflix::Application.routes.draw do


  get 'ui(/:action)', controller: 'ui'
  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  get 'home', to: 'videos#index'
  get 'sign_out', to: 'sessions#destroy'
  get 'my_queue', to: 'queue_items#index'

  resources :videos, only: [:index, :show] do
    collection do
      post :search, to: 'videos#search'
    end
    resources :reviews, only: [:create]
#    resources :queue_items, only: [:create, :destroy]
  end

  resources :categories, only: [:show]
  resources :queue_items, only: [:create, :destroy]
  post 'update_queue', to: 'queue_items#update_queue'

  resources :users, only: [:create]
  resources :sessions, only: [:create]

  root to: 'pages#front'
end
