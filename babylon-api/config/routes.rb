Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }

  namespace :api, defaults: { format: 'json'  } do
    scope '/app', module: :app do
      resources :contacts
    end
  end

  mount API::Base, at: "/"
  mount GrapeSwaggerRails::Engine, at: "/documentation"

  root 'pages#index'

  # Experimental
  get '/assets/:name.:ext' => redirect {|params, req| "http://guides.rubyonrails.org/images/#{params[:name]}.#{params[:ext]}"}

  get  '*path' =>  'pages#index'
end
