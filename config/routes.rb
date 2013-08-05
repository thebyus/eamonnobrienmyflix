Myflix::Application.routes.draw do
	root to: 'videos#home'

	get '/show', to: 'videos#show'
  get 'ui(/:action)', controller: 'ui'
end
