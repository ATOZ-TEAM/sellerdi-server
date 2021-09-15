Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :exchange do
      scope controller: :read do
        get '', action: 'all', as: 'index'
        get ':base_currency/:compare_currency_list', action: 'compare', as: 'compare'
      end
    end
  end
end
