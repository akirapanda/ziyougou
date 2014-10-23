Ziyougou::Application.routes.draw do
  mount WeixinRailsMiddleware::Engine, at: "/"


  namespace :admin do
  
  
  end
    

  namespace :mobile do
    root :to => 'home#index'
  
  end
  
end
