Jannop::Application.routes.draw do
  match "site(/index)" => "site#index", :via => :get

  resource :session, :only => [:new, :create, :destroy] do
    get :confirm_new
  end

  resources :coins, except: [:new, :show] do
    collection do
      get :new_common
      get :new_commemorative
      match '/:country', action: :show_country, as: :show_country, constraints: { country: /[a-z]{2}/ }
      match '/:nominal', action: :show_nominal, as: :show_nominal, constraints: { nominal: /(2\.00|1\.00|0\.50|0\.20|0\.10|0\.05|0\.02|0\.01)/ }
      match '/:year', action: :show_year, as: :show_year, constraints: { year: /\d{4}/ }
    end
  end

  resources :users

  namespace :admin do
    resources :countries
  end

  root :to => 'site#index'
end
