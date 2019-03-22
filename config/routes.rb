Rails.application.routes.draw do
  namespace :admin do
      resources :test_results
      resources :tools
      resources :benchmark_names

      root to: "test_results#index"
    end
  root to: 'pages#index'

  get '/show/:id', :to => 'pages#show', :as => 'show_tool'
end
