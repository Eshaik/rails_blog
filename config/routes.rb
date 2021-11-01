# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'articles#index'
  get '/notfound', to: "others#notfound"

  #devise_scope :user do
  #  get '/signout', to: 'devise/sessions#destroy', as: :signout
  #end

  resources :articles do
    resources :comments
  end
end
