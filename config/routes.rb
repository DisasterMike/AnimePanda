Rails.application.routes.draw do
  devise_for :users
  root to: "animes#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :animes, only: [:index, :show]

  get "animes/recommendations", to: "animes#show_recommendations"
  post "animes/recommendations", to: "animes#request_recommendations"

  resources :bookmarks, only: [:create, :update, :destroy]

  get "lists/watchlist", to: "lists#show_watchlist"
  get "lists/liked", to: "list#show_liked"
end
