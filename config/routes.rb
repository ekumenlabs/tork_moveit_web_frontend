Rails.application.routes.draw do

  root to: 'home#index'

  scope '/home' do
    get 'index', to: 'home#index', as: 'home_index'
  end

end
