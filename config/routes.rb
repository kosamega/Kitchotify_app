Rails.application.routes.draw do
  root to: 'static_pages#home'

  resources :albums do
    resources :musics, only: %i[new create edit update show destroy]
    resource :index, only: %i[create]
    resource :music_list, only: %i[create]
  end

  resources :daikichis, only: %i[new create edit update show destroy]

  resources :artists

  resources :designers

  resources :comments, only: %i[create]

  resources :likes, only: %i[create destroy index]

  resources :music_playlist_relations, only: %i[create destroy]
  resources :playlists, only: %i[create update destroy index show] do
    resource :position, only: %i[update]
  end

  resources :user_artist_ownerships, only: %i[create destroy]
  resources :user_designer_ownerships, only: %i[create destroy]

  resource :sessions, only: %i[new create destroy]
  resources :users, only: %i[new create show edit update index]

  resources :intro_quizzes, only: %i[index show new]
  resources :quiz_results, only: %i[create show index]

  resources :searches, only: %i[index]

  resource :import_csvs, only: %i[new show create]
  resource :add_music_length, only: %i[new create]

  resources :daikichi_forms do
    resources :daikichi_votes
    resource :daikichi_result, only: %i[show]
  end

  namespace :api, defaults: { format: :json } do
    resources :albums, only: %i[index create]
    resources :musics, only: %i[index]
    resources :artists, only: %i[index]
  end
end
