Rails.application.routes.draw do
  resources :products
  resources :line_items

  root 'products#index'
end
