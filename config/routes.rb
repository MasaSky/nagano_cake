Rails.application.routes.draw do
  root to: 'public/homes#top'
  get '/about' => 'public/homes#about'
  get '/admin' => 'admin/homes#top'

  scope module: :public do
    devise_for :customers, controllers: {registrations: 'public/registrations', sessions: 'public/sessions'}

    resources :items, only: [:index, :show]
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
    devise_for :admin, controllers: {sessions: 'admin/sessions'}

    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_items, only: [:update]
  end

end
