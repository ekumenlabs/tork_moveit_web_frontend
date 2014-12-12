Rails.application.routes.draw do

  devise_for :users

  root to: 'simulation#index'

  get '/simulation',              to: 'simulation#index', as: 'simulation_index'
  get '/simulation/ping.:format', to: 'simulation#ping',  format: 'json'

end
