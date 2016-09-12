Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  root "home#index"
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: "users/passwords",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  get 'application/upper_panel', to: 'application#upper_panel', as: 'upper_panel'

  get 'home/book_for_carousel', to: 'home#book_for_carousel', as: 'book_for_carousel'

  get 'shop', to: 'shop#index', as: 'shop'
  get 'shop/list', to: 'shop#list', as: 'categories'

  get 'settings', to: 'settings#index', as: 'settings'

  get 'addresses/address', to: 'addresses#address', as: 'address'
  get 'users/email/edit_email', to: 'users/email#edit_email', as: 'user_edit_email'
  get 'users/passwords/edit_password', to: 'users/passwords#edit_password', as: 'user_edit_password'

  get 'admin', to: 'rails_admin/main#dashboard', as: 'admin'

  resources :reviews, only: [:new, :update]
  resources :addresses, only: [:create, :update]
  resources :authors, only: :show
  resources :books, only: :show
  resources :order_items, only: [:create, :destroy]
  resources :orders, only: [:index, :edit, :update, :show, :destroy] do
    member do
      get 'addresses', action: 'edit_address', as: 'edit_address'
      get 'delivery', action: 'edit_delivery', as: 'edit_delivery'
      get 'payment', action: 'edit_payment', as: 'edit_payment'
      get 'confirm', action: 'edit_confirm', as: 'edit_confirm'
      get 'complete', action: 'complete', as: 'complete'
      put 'addresses', action: 'order_address', as: 'address'
      put 'delivery', action: 'order_delivery', as: 'delivery'
      put 'payment', action: 'order_payment', as: 'payment'
      put 'confirm', action: 'order_confirm', as: 'confirm'
    end
  end

  match "*path" => redirect("/"), via: [:get]
end
