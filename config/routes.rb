Ziyougou::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  mount WeixinRailsMiddleware::Engine, at: "/"


  namespace :admin do
    root :to => 'home#index'
    
    resources :sellers do
      member do 
        get "shops"
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
    resources :discount_codes
    resources :users
  
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
    

    resources :discount_codes
    resources :discount_events do
      member do
        get 'apply'
        get 'download'
      end
    end
    
    
  end
  
end
