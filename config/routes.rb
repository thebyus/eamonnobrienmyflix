Myflix::Application.routes.draw do
	root to: 'videos#home'

	get '/videos/:id', to: 'videos#show'
  get 'ui(/:action)', controller: 'ui'
end
