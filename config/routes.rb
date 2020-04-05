# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :stores
  resources :visitors
  resources :users, only: %i[create index update]
end
