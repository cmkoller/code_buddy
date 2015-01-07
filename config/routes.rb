Rails.application.routes.draw do
  devise_for :users

  root 'buddies#index'
  resources :buddies do
    resources :reviews, only: [:create]
  end

  resources :reviews, only: [:update, :destroy, :edit] do
    resources :votes, only: [:create]
  end

  namespace :admin do
    resources :users, only: [:index, :destroy, :update]
  end
  resources :users, only: [:show]

  # Example buddy route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     buddies :products
  #   end
end
