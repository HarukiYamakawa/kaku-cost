Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'health_check', to: 'health_check#index'
      mount_devise_token_auth_for 'Customer', at: 'auth', controllers: {
        registrations: 'api/v1/auth_registrations'
      }
      resources :products, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
