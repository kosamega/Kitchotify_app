Rails.application.routes.draw do
  root to: 'static_pages#home'
  
  resources :albums do
    resources :musics, only: %i[new create edit update show destroy]
    resource :index, only: %i[create]
    resource :music_list, only: %i[create]
  end

  resources :artists

  resources :comments, only: %i[create]
  
  resources :likes, only: %i[create destroy index]
  
  resources :music_playlist_relations, only: %i[create destroy]
  resources :playlists, only: %i[create update destroy index show] do
    resource :positions, only: %i[update]
  end

  resource :sessions, only: %i[new create destroy]
  resources :users, only: %i[new create show edit update index]

  resources :intro_quizzes, only: %i[index show new]
  resources :quiz_results, only: %i[create show index]

  resources :searches, only: %i[index]
end
