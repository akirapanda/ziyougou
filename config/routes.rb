Ziyougou::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  mount WeixinRailsMiddleware::Engine, at: "/"


  namespace :admin do
    root :to => 'home#index'
    resources :shops
  
  
  end
    

  namespace :mobile do
    root :to => 'home#index'
    resources :shops
    resources :trip_guides
    resources :recommend_events
  end
  
end
