# frozen_string_literal: true

namespace :admin do
  root to: 'orders#index'
  resources :schedules
  resources :listings
  resources :users

  namespace :orders do
    resources :drafts
    resources :archives
  end

  resources :orders do
    resource :invoice, only: :show
  end

  resources :images, only: :destroy
  namespace :settings do
    root to: 'settings#index'
    resource :general, only: %i[show create]
    resource :banking, only: %i[show create]
    resource :legal, only: %i[show create]
    resource :shipping, only: %i[show create]
    resources :weight_shipping_rates
    resources :price_shipping_rates
    resource :rates, only: %i[show create]
    resources :slides
    resource :account do
      get 'resend', on: :member
    end
  end
end
