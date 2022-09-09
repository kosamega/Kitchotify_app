Rails.application.routes.draw do
  get '/', to: "static_pages#home"

  resources :users
    
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  
  resources :albums
  resources :musics, only: [:show]
  resources :likes
  
  resources :comments

  get '/search/result', to: "searchs#index"
  
  resources :playlists

  resources :music_playlist_relations
end
