Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users
    end
  end

  namespace :api do
    namespace :v1 do
      resources :games
    end
  end

  namespace :api do
    namespace :v1 do
      resources :songs
    end
  end

  #Auth
  namespace :api do
    namespace :v1 do
      get '/login', to: "auth#spotify_request"
      get '/auth', to: "auth#show" #what are we using this for?
      get '/user', to: "users#create"
    end
  end

  #Resources
  resources :users
  resources :songs
  resources :games
end
