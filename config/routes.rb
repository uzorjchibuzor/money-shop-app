Rails.application.routes.draw do

  resources :transactions

  get 'filter_transaction', to: 'home#filter_transactions'

  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#log_in'
  delete '/sign_out', to: 'sessions#log_out'

  get 'home/index'
  root 'home#index'
end
