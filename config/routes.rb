Rails.application.routes.draw do
  resources :users

  resources :trailheads do
    collection do
      post "email"
    end
  end

  root :to => "home#index"
  end
