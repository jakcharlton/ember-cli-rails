Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, controllers: { sessions: 'sessions' }

  ActiveAdmin.routes(self)

  namespace :api, defaults: { format: 'json'  } do
    scope '/app', module: :app do
      resources :contacts
    end
  end

  mount API::Base, at: "/"
  mount GrapeSwaggerRails::Engine, at: "/documentation"

  root 'pages#index'

  get  '*path' =>  'pages#index'
end
