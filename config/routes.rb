Rails.application.routes.draw do
  devise_for :users, path_prefix: "devise", controllers: { registrations: "registrations" }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_scope :user do
        post "login" => "sessions#create", as: "login"
        delete "logout" => "sessions#destroy", as: "logout"
        put "password/update", to: "registrations#update_password"
      end

      resources :users, only: [:show, :create, :update, :destroy], constraints: { id: /.*/ }
      resources :products, only: [:index, :create, :update, :show] do
        collection do
          post 'bulk_delete'
        end
      end
      resources :vendors, only: [:index, :create, :update] do
        collection do
          post 'bulk_delete'
        end
      end
      resources :stocks, only: [:index, :update, :create] do
        collection do
          post 'bulk_delete'
        end
      end
      resources :transactions, only: :create
    end
  end

  root "home#index"
  get '*path', to: 'home#index', via: :all
end
