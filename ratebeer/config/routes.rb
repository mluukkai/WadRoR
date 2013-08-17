Ratebeer::Application.routes.draw do
  resources :styles


  resources :users
  resources :beers
  resources :breweries
  resources :ratings, :only => [:index, :new, :create, :destroy]
  resources :sessions, :only => [:new, :create, :destroy]
  resources :places, :only => [:index, :show]
  post "places" => "places#search"

  get "signup" => "users#new"
  get "signin" => "sessions#new"
  get "signout" => "sessions#destroy"

  get 'beerlist' => 'beers#list'

  root :to => 'breweries#index'
end
