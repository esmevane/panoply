Panoply::Application.routes.draw do

  authenticated :user do
    root to: 'home#index'
  end

  constraints(SubdomainConstraint) do
    resources :appointments, only: [ :index ]
    root to: 'appointments#index'
  end

  match 'appointments', to: redirect('/')

  root to: "home#index"

  devise_for :users

end