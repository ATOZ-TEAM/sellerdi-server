Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root to: 'home#index'

  namespace :api, defaults: { format: :json } do
    namespace :exchange do
      scope controller: :read do
        get '', action: 'all', as: 'index'
        get ':base_currency/:compare_currency_list', action: 'compare', as: 'compare'
      end
    end

    resources :orders
    resources :shops do
      resources :orders
    end
  end
end
