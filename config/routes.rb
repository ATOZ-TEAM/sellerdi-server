Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root to: 'home#index'

  namespace :api, defaults: { format: :json } do
    namespace :users do
      scope controller: :sessions do
        post 'login', action: :create
        delete 'logout', action: :destroy
      end
    end

    namespace :exchange do
      scope controller: :read do
        get '', action: 'all', as: 'index'
        get ':base_currency/:compare_currency_list', action: 'compare', as: 'compare'
      end
    end

    resources :orders

    scope only: %i[index show create update destroy] do
      resources :users, only: [] do
        resources :shops do
          resources :orders
          resources :receivable_documents
        end
      end
    end
  end
end
