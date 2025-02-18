Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  constraints CompanyConstraint.new do
    namespace :app do
      resource :agenda, only: :show
      resources :activities, only: [] do
        resources :reservations, only: [ :new, :create ]
      end
      resources :reservations, only: [ :index, :show, :destroy ]
      resources :events, only: :index

      root to: "customers#show"
    end

    namespace :admin do
      resources :activities
      resources :attendances, only: [ :index, :show, :new, :create, :destroy ]
      resource :company, only: [ :edit, :update ]

      root to: "companies#show"
    end

    resources :customers, only: [ :new, :create ]
    root to: "companies#show", as: :company_root
  end

  scope module: :public do
    resources :companies, only: :create

    root to: "site#index"
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
