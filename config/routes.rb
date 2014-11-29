Rails.application.routes.draw do

  devise_for :users

  root to: 'home#index'

  scope '/home' do
    get 'index', to: 'home#index', as: 'home_index'
  end

end
