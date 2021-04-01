# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users, controllers: { sessions: 'sessions',
                                    registrations: 'registrations',
                                    passwords: 'passwords',
                                    invitations: 'invitations',
                                    confirmations: 'confirmations' }

  get 'shop', to: 'pages#shop'
  get 'prices', to: 'pages#prices'
  get 'payment_details', to: 'pages#payment_details'
  get 'track_order', to: 'pages#track_order'
  get 'order_status', to: 'pages#order_status'
  get 'about', to: 'pages#about'
  get 'policies', to: 'pages#policies'
  get 'terms_service', to: 'pages#terms_service'
  get 'calculator', to: 'pages#calculator'

  get 'dashboard', to: 'orders#index'
  resources :orders, only: %i[index show] do
    resource :invoice, only: :show
  end

  resource :contact, only: :show
  resource :cart, only: :show
  resources :checkouts
  resources :line_items
  resources :listings do
    resources :line_items, only: %i[new create]
  end

  draw :admin
  draw :api_v1

  get '*unmatched_route', to: 'application#route_not_found'
end
