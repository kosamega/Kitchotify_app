Rails.application.routes.draw do
  get '/', to: "static_pages#home"
  
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  
  get '/albums/:id', to: "albums#show"
  
  get '/musics/:id', to: "musics#show"
  
  post '/likes/:id/create', to: "likes#create"
  delete '/likes/:id/destroy', to: "likes#destroy"
  get '/likes/index', to: "likes#index"
  
  post '/comments/create', to: "comments#create"

  post '/search/create', to: "searchs#create"
  get '/search/result', to: "searchs#index"
  
  post 'playlists/create', to: "playlists#create"
  get 'playlists/:id', to: "playlists#show"
  delete 'playlists/:id', to: "playlists#destroy"

  post 'music_playlist_relations/create/:music_id/:playlist_id', to: "music_playlist_relations#create"
  delete 'music_playlist_relations/destroy/:music_id/:playlist_id', to: "music_playlist_relations#destroy"
end
