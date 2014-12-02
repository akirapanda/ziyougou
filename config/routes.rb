Ziyougou::Application.routes.draw do
  devise_for :admin_users
  mount Ckeditor::Engine => '/ckeditor'
  mount WeixinRailsMiddleware::Engine, at: "/"


  namespace :admin do
    root :to => 'home#index'
    
    resources :sellers do
      member do 
        get "shops"
      end
    end
    
    resources :recommend_events
    resources :wx_keywords
    resources :settings
    
    resources :admin_users do
      member do
        get 'edit_password'
        patch 'update_password'
      end
    end
    
    resources :shops do
      member do 
        get "discount_events"
      end
    end
    
    resources :discount_events do
      member do 
        get "discount_codes"
      end
    end
    
    resources :discount_codes do
      member do
        get "to_cancel"
        get "to_active"
        get "to_inactive"
        get "to_confirm"
        patch 'upload_code'
      end
    end
    resources :users do
      member do
        get 'passport'
      end
    end
  
  end
    

  namespace :mobile do
    root :to => 'home#index'
    resources :sellers
    
    resources :shops
    resources :trip_guides
    
    resources :recommend_events 
    
    
    
    resources :users do
      member do
        get 'passport'
      end
    end
    resources :sessions, only: [:new, :create, :destroy]
    match '/signup',    to: 'users#new',              via: 'get'
    match '/signin',    to: 'sessions#new',           via: 'get'
    match '/signout',   to: 'sessions#destroy',       via: 'delete'
    match '/index',     to: 'home#index',             via: 'get'
    match '/forget_password',   to: 'sessions#lost_password',       via: 'get'
    match '/send_password',   to: 'sessions#send_password',       via: 'post'
    match '/reset_password',   to: 'sessions#reset_password',       via: 'get'
    match '/change_password',   to: 'sessions#change_password',       via: 'patch'
    

    resources :discount_codes do
      member do
        get 'detail'
      end
    end
    resources :discount_events do
      member do
        get 'apply'
        get 'download'
      end
    end
    
    
  end
  
end
