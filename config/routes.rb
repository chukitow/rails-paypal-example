Rails.application.routes.draw do
  resources :products
  resources :line_items

  namespace :paypal do
    resources :checkouts, only: [:create] do
      collection do
        get :complete
      end
    end
  end

  root 'products#index'
end
