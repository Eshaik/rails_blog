# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'articles#index'
  get '/notfound', to: "others#notfound"

  resources :articles do
    resources :comments
  end
end
