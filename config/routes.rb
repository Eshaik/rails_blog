# frozen_string_literal: true

Rails.application.routes.draw do
  root 'articles#index'
  get '/notfound', to: "others#notfound"

  resources :articles do
    resources :comments
  end
end
