Myflix::Application.routes.draw do


  get 'ui(/:action)', controller: 'ui'
  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'

  resources :videos, only: [:index, :show] do
  	collection do
  		post :search, to: 'videos#search'
  	end
  end

  resources :categories, only: [:show]
  resources :users, only: [:create]

  root to: 'pages#front'
end
