KIWA::Application.routes.draw do
  resources :projects, :path => "collections" # Alias projects as collections

  resources :project_items

  resources :comments

  devise_for :users, :controllers => { :invitations => 'invitations' }

  resources :accept_user_invitation

  root :to => "pages#home"
  
  resources :searches
  match 'pages/:action', :controller => :pages
    
  resources :crew_list_entries

  resources :voyages do 
    get :autocomplete, :on => :collection
  end

  resources :expeditions do 
    get :autocomplete, :on => :collection
  end

  resources :people do 
    get :autocomplete, :on => :collection
  end

  resources :events

  resources :cards do 
    get :autocomplete, :on => :collection
  end

  resources :researchers

  resources :labels do 
    get :autocomplete, :on => :collection
  end

  resources :media_items

  resources :archives

  resources :inventory_list_entries

  resources :artefacts

  resources :inventories do 
    get :autocomplete, :on => :collection
  end

  resources :institutions
  
  resources :encounters do
    get :autocomplete, :on => :collection
  end
  
  resources :source_encounters, :controller => :encounters, :defaults => {:type => 'Source'}
  resources :aofe_encounters, :controller => :encounters, :defaults => {:type => 'AOFE'}

  resources :relations
  
  resources :locations do 
    get :autocomplete, :on => :collection
  end
      
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
