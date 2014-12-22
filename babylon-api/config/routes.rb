Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, controllers: { sessions: 'sessions' }

  ActiveAdmin.routes(self)

  mount API::Base, at: "/"
  mount GrapeSwaggerRails::Engine, at: "/documentation"

    root 'pages#index'
end
