KIWA::Application.routes.draw do
  resources :projects, :path => "collections" do # Alias projects as collections
    get :export, :on => :member
  end

  resources :project_items do
    get :autocomplete, :on => :collection
  end

  resources :comments

  devise_for :users, :controllers => { :invitations => 'invitations' }

  resources :accept_user_invitation

  root :to => "pages#home"
  
  resources :searches do
    get :autocomplete, :on => :collection
  end

  match 'pages/:action', :controller => :pages, :as => :pages
    
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
  
  resources :source_encounters, :controller => :encounters, :defaults => {:encounter_type => 'Source'} do
    get :autocomplete, :on => :collection
  end
  resources :aofe_encounters, :controller => :encounters, :defaults => {:encounter_type => 'AOFE'} do
    get :autocomplete, :on => :collection
  end

  resources :relations
  
  resources :locations do 
    get :autocomplete, :on => :collection
  end
end
