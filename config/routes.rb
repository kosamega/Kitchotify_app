Rails.application.routes.draw do
  get '/', to: "static_pages#home"

  get '/albums/:id', to: "albums#show"

  get '/musics/:id', to: "musics#show"
end
