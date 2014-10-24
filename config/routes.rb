Ziyougou::Application.routes.draw do
  mount WeixinRailsMiddleware::Engine, at: "/"


  namespace :admin do
  
  
  end
    

  namespace :mobile do
    root :to => 'home#index'
    resources :shops
    resources :trip_guides
    resources :recommend_events
  end
  
end
