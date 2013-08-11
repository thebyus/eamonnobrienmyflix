Myflix::Application.routes.draw do
	root to: 'pages#front'

	get '/videos/:id', to: 'videos#show'
	
  get 'ui(/:action)', controller: 'ui'
  get'register', to: 'users#new'

  resources :videos, only: [:index, :show] do
  	collection do
  		post :search, to: 'videos#search'
  	end
  end

  resources :categories, only: [:show]
  resources :users, only: [:create]
end
