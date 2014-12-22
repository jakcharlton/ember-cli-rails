Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, controllers: { sessions: 'sessions' }


  root 'application#index'

  ActiveAdmin.routes(self)

  mount API::Base, at: "/api"

  mount GrapeSwaggerRails::Engine, at: "/documentation"
end
