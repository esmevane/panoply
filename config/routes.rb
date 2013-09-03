Panoply::Application.routes.draw do

  constraints(SubdomainConstraint) do
    resources :appointments, only: [ :index ]
    resources :requests, only: [ :new, :create ] do
      collection do
        get 'new/:slot', to: :new, as: :make
      end
    end
    root to: 'appointments#index'
  end

  resources :subscriptions, only: [ :create, :new ]
  match 'appointments', to: redirect('/')
  root to: "home#index"
  devise_for :users

end