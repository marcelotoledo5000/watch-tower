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
end
