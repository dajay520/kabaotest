Kabaotest::Application.routes.draw do
  resources :interfaces

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
  match 'api/kabao.do' => 'service#process'
  match 'config/:id' => 'config#interface'
  match 'config/create/:id' => 'config#create_condition'
  match 'config/:interface_id/condition/del/:id' => 'config#del_condition'
  match 'config/modify/:id' => 'config#mod_condition'
  match 'config/edit/:id' => 'config#go_to_edit'
  match 'config/edit_commit/:id' => 'config#edit_commit'
  match 'services/partnerExterfaceFacade' => 'config#test'
  
  match 'config/get_logs/:id/:logsid'=>'config#get_logs'
  match '/config/logs/show/:id'=>'config#show_logs'
  match '/config/logs/del/:id'=>'config#del_logs'
  
  match '/config/condition/show_response/:id'=>'config#show_response'
  
   match '/help'=>'help#help'
  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => 'config#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
