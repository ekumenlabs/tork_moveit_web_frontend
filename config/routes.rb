Rails.application.routes.draw do

  # Devise for admin users
  devise_for :admin_users, ActiveAdmin::Devise.config

  # Active Admin
  ActiveAdmin.routes(self)

  # Devise for non-admin users
  devise_for :users

  root to: 'simulation#index'

  get '/simulation',              to: 'simulation#index', as: 'simulation_index'
  get '/simulation/ping.:format', to: 'simulation#ping',  format: 'json'

end
