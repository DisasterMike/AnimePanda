Rails.application.routes.draw do
  get 'users/edit'
  get 'users/update'
  devise_for :users, controllers: {
  registrations: 'users/registrations',
  sessions: 'users/sessions'
  }
  resources :users, only: [:edit, :update]

  # devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: "animes#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :animes, only: [:show] do
    collection do
      get :recommendations, param: :likes
    end

    member do
      post :like
    end
  end
  # resources :animes, only: [:index, :show]
  resources :animes, only: [:show]

  post "animes/recommendations", to: "animes#request_recommendations"

  resources :bookmarks, only: [:create, :update, :destroy]

  get "lists/watchlist", to: "lists#show_watchlist"
  get "lists/liked", to: "lists#show_liked"
end
