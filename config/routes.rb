# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout'
             },
             controllers: {
               sessions: 'sessions',
             }

  resources :stores
  resources :visitors
  resources :users, only: %i[create index update]
  resources :appointments, only: %i[create index]
  resources :reports, only: :index

  get 'up' => 'rails/health#show', as: :rails_health_check
end
