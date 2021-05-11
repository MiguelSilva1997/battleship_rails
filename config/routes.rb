Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/games/:session_id', to: 'games#show'
  post '/games/new', to: 'games#create'
  post '/games/:session_id/setup', to: 'games#setup'
  post '/games/:session_id/play', to: 'games#play'
end
