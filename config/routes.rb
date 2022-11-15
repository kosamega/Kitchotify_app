Rails.application.routes.draw do
  root to: "static_pages#home"

  resources :albums, only: %i[show]
  resources :comments, only: %i[create]
  resources :likes, only: %i[create destroy index]
  resources :music_playlist_relations, only: %i[create destroy]
  resources :musics, only: %i[show]
  resources :playlists, only: %i[create update destroy index show]
  post '/playlists/:id/sort', to: "playlists#sort"
  resources :users, only: %i[new create show edit update index]
  resources :intro_quizzes, only: %i[index show]

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  get '/search/result', to: "searchs#index"
end
