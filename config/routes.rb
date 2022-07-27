Rails.application.routes.draw do
  get 'likes/create'
  get '/', to: "static_pages#home"
  
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  get '/albums/:id', to: "albums#show"

  get '/musics/:id', to: "musics#show"

  post '/likes/:id/create', to: "likes#create"
  delete '/likes/:id/destroy', to: "likes#destroy"
  get '/likes/index', to: "likes#index"

  post '/search/create', to: "searchs#create"
  get '/search/result', to: "searchs#index"
end
