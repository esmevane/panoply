Panoply::Application.routes.draw do

  constraints(SubdomainConstraint) do
    resources :appointments, only: [ :index ]
    resources :requests, only: [ :new, :create ]
    root to: 'appointments#index'
  end

  match 'appointments', to: redirect('/')

  root to: "home#index"

  devise_for :users

end