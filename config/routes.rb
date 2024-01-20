Rails.application.routes.draw do

  devise_for :customers, controllers: {registrations: 'public/registrations', sessions: 'public/sessions'}
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {sessions: "admin/sessions"}

  scope module: :public do
    root to: 'homes#top'
    get "about", to: "homes#about", as: :about
    resources :items, only: [:index, :show] do
      collection do
        get 'search_word' => 'items#search_word'
      end
    end
    resources :customers, only: [:show, :edit, :update] do
      member do
        get 'info'
        get 'quit'
        patch 'deactive'
      end
    end
    resources :deliveries, only: [:index, :create, :edit, :update, :destroy]
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete 'cart_items' => 'cart_items#destroy_all'
      end
    end
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post 'confirm'
        get 'complete'
      end
    end
  end

  namespace :admin do
    root to: "homes#top"

    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_items, only: [:update]
  end

end
