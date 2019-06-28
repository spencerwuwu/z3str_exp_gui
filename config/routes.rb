Rails.application.routes.draw do
  namespace :admin do
      resources :test_results
      resources :tools
      resources :benchmark_names
      resources :benchmark_types
      resources :days_to_runs
      resources :display_types

      root to: "test_results#index"
    end
  root to: 'pages#index'

  get '/show/:id', :to => 'pages#show', :as => 'show_tool'
  get '/benchmark_type/:id', :to => 'pages#show_type', :as => 'show_type'
  get '/log/:id', :to => 'pages#log', :as => 'log'
  get '/logerr/:id', :to => 'pages#logerr', :as => 'logerr'
  get '/show_diff/:id1/:id2', :to => 'pages#show_diff', :as => 'show_diff'
end
