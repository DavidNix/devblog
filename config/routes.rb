Devblog::Application.routes.draw do

  root to: 'static_pages#home'
  match 'about', to: 'static_pages#about'
  match 'products', to: 'static_pages#products'
  
  match 'contact', to: 'contact#new', via: :get
  match 'contact', to: 'contact#create', via: :post
  match 'contact_email_only', to: 'contact#create_email_only', via: :post

  devise_for :admins, controllers: { registrations: "admin_registrations" }

  devise_scope :admin do
    get "admin", to: "devise/sessions#new"
  end

  # uses the articles controller's show
  resources :posts, except: :show

  get "articles", to: "articles#index"
  get 'articles/:id', to: "articles#show", as: :article
  get 'archives', to: "archives#index"

  get 'sitemap', to: "sitemap#index"

  # social icons routing
  get 'social_icons/twitter', to: 'social_icons#twitter', as: :sm_twitter
  get 'social_icons/rss', to: 'social_icons#rss', as: :sm_rss
  get 'social_icons/email', to: 'social_icons#email', as: :sm_email

  # A/B Split testing
  mount Split::Dashboard, at: 'split'

  # to see easily in the dev environment
  if Rails.application.config.consider_all_requests_local
    get '404', to: 'error#error_404'
    get '500', to: 'error#error_500'
  end

  # source: http://ramblinglabs.com/blog/2012/01/rails-3-1-adding-custom-404-and-500-error-pages
  # the below must be the last route
  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'error#error_404'
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
