Rails.application.routes.draw do
  get '/', to: "static_pages#home"

  resources :users
    
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  
  resources :albums
  # get '/albums/:id', to: "albums#show"
  
  get '/musics/:id', to: "musics#show"
  
  resources :likes
  post '/likes/:id/create', to: "likes#create"
  delete '/likes/:id/destroy', to: "likes#destroy"
  get '/likes', to: "likes#index"
  
  post '/comments/create', to: "comments#create"

  get '/search/result', to: "searchs#index"
  
  resources :playlists
  # post 'playlists/create', to: "playlists#create"
  # get 'playlists/index', to: "playlists#index"
  # get 'playlists/:id', to: "playlists#show"
  # post 'playlists/:id', to: "playlists#edit"
  # delete 'playlists/:id', to: "playlists#destroy"

  resources :music_playlist_relations
  # post 'music_playlist_relations/create/:music_id/:playlist_id', to: "music_playlist_relations#create"
  # delete 'music_playlist_relations/destroy/:music_id/:playlist_id', to: "music_playlist_relations#destroy"
end
