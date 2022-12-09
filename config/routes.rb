Rails.application.routes.draw do
  devise_for :users
  root 'articles#index'
  get 'analytics', to: 'searches#index'

  resources :articles
end
