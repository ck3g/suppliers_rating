SuppliersRating::Application.routes.draw do

  match "/users/sign_up" => redirect("/users/sign_in")
  devise_for :users

  root :to => 'welcome#index'
end
