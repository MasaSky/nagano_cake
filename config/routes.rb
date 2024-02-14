Rails.application.routes.draw do

  devise_for :customers,skip: [:passwords], controllers: {registrations: 'public/registrations', sessions: 'public/sessions'}
  devise_for :admin,skip: [:registrations, :passwords], controllers: {sessions: "admin/sessions"}

  scope module: :public do
    root to: 'homes#top'
    get "about" => "homes#about", as: :about
    get 'info' => 'customers#show'
    get 'info/edit' => 'customers#edit'
    patch 'info/update' => 'customers#update'
    get 'info/quit' => 'customers#quit'
    patch 'deactive' => 'customers#deactive'
    resources :deliveries, only: [:index, :create, :edit, :update, :destroy]
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete 'cart_items' => 'cart_items#destroy_all', as: 'destroy_all'
      end
    end
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post 'confirm' => 'orders#confirm', as: 'confirm'
        get 'complete' => 'orders#complete', as: 'complete'
      end
    end
    resources :items, only: [:index, :show] do
      collection do
        get 'search_genres' => 'items#search_genres', as: 'genres'
        get 'search_word' => 'items#search_word', as: 'search'
      end
    end
  end

  namespace :admin do
    root to: "homes#top"
    resources :items, only: [:index, :new, :create, :show, :edit, :update] do
      collection do
        get 'search_genres' => 'items#search_genres', as: 'genres'
        get 'search_word' => 'items#search_word', as: 'search'
      end
    end
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :orders, only: [:index, :show, :update]
    resources :order_items, only: [:update]
  end

end
