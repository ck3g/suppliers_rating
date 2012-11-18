SuppliersRating::Application.routes.draw do

  match "/users/sign_up" => redirect("/users/sign_in")
  devise_for :users

  resources :suppliers do
    get :autocomplete_supplier_name, on: :collection
  end

  resources :services do
    get :autocomplete_service_name, on: :collection
  end

  resources :supplier_services do
    resources :tasks, only: [:new]
  end

  resources :tasks, except: [:new] do
    post :reopen, on: :member
    resources :comments, only: [:create, :destroy]
  end

  root :to => 'tasks#index'
end
