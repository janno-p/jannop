Jannop::Application.routes.draw do
  get "site", :controller => :site, :action => :index
  get "site/index"

  resource :session, :only => [:new, :create, :destroy] do
    get :confirm_new
  end

  resources :users

  namespace :admin do
    resources :countries
  end

  root :to => 'site#index'
end
