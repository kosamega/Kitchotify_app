Rails.application.routes.draw do
  get '/', to: "static_pages#home"
  
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  get '/albums/:id', to: "albums#show"

  get '/musics/:id', to: "musics#show"
end
