Jannop::Application.routes.draw do
  match "site(/index)" => "site#index", :via => :get

  resource :session, :only => [:new, :create, :destroy] do
    get :confirm_new
  end

  resources :users

  namespace :admin do
    resources :countries
  end

  root :to => 'site#index'
end
