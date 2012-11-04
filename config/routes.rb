SuppliersRating::Application.routes.draw do

  match "/users/sign_up" => redirect("/users/sign_in")
  devise_for :users

  resources :suppliers, :services

  root :to => 'welcome#index'
end
