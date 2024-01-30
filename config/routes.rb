Rails.application.routes.draw do
  resources :pages, except: [:show]
  get '/pages/:permalink' => "pages#permalink", as: "permalink"
  # get 'home/index'
  root to: "home#index"
  # get 'production_companies/index'
  # get 'production_companies/show'
  # get 'movies/index'
  # get 'movies/show'
  resources :movies, only: [:index, :show]
  resources :production_companies, only: [:index, :show]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
