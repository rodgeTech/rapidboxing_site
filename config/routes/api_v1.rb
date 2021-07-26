# frozen_string_literal: true

namespace :api do
  namespace :v1 do
    mount_devise_token_auth_for 'User',
                                at: 'auth',
                                skip: [:omniauth_callbacks],
                                controllers: {
                                  confirmations: 'api/v1/confirmations',
                                  registrations: 'api/v1/registrations'
                                }

    resources :listings, only: %i[show index]
    resources :line_items
    resources :users, only: :index
    resource :profile, only: :show
    resource :calculator, only: :show
    resources :contacts, only: :create

    resources :order_items, only: :update
    get 'track_order/:id', to: 'orders#track_order'
    resources :invoices, only: :create
    resources :deposits, only: %i[create destroy]
    resource :cart, only: %i[show]
    namespace :settings do
      resource :legal, only: %i[show]
      resources :shipping_rates, only: %i[index]
      resources :weight_shipping_rates, only: %i[index]
      resources :price_shipping_rates, only: %i[index]
    end
    namespace :orders do
      resources :drafts, only: %i[show new create destroy] do
        resources :draft_items, only: %i[index]
        patch 'publish', on: :member
      end
      resources :draft_items, only: %i[create]
    end
    resources :orders, only: %i[index show create] do
      post 'email_invoice', on: :member
      put 'status_update', on: :member
      patch 'archive', on: :member
    end
  end
end
