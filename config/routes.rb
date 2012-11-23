SuppliersRating::Application.routes.draw do

  match "/users/sign_up" => redirect("/users/sign_in")
  devise_for :users

  resources :suppliers do
    get :autocomplete_supplier_name, on: :collection
    get :tasks, on: :member
  end

  resources :services do
    get :autocomplete_service_name, on: :collection
    get :tasks, on: :member
  end

  resources :supplier_services do
    resources :tasks, only: [:new]
  end

  resources :tasks, except: [:new] do
    post :reopen, on: :member
    post :create_from_scratch, on: :collection
    resources :comments, only: [:create, :destroy]
  end

  get "new_task" => "tasks#new_from_scratch", as: :new_from_scratch

  root :to => 'welcome#index'
end
