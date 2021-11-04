# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'articles#index'
  get '/notfound', to: 'others#notfound'

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :follows, only: %i[create destroy]

  resources :articles do
    resources :comments
  end
end
