Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'buddies#index'
  resources :buddies do
    resources :reviews
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example buddy route (maps HTTP verbs to controller actions automatically):
  #   buddies :products

  # Example buddy route with options:
  #   buddies :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example buddy route with sub-buddies:
  #   buddies :products do
  #     buddies :comments, :sales
  #     buddy :seller
  #   end

  # Example buddy route with more complex sub-buddies:
  #   buddies :products do
  #     buddies :comments
  #     buddies :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example buddy route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   buddies :posts, concerns: :toggleable
  #   buddies :photos, concerns: :toggleable

  # Example buddy route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     buddies :products
  #   end
end
