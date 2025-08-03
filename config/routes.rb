Rails.application.routes.draw do
  root 'home#index'

  # Authentication routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'

  # User registration
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  # Products and categories
  resources :products, only: [:index, :show] do
    resources :reviews, only: [:create]
    collection do
      get :search
    end
  end

  # Shopping cart
  get '/cart', to: 'cart#show'
  post '/cart/add', to: 'cart#add'
  patch '/cart/update', to: 'cart#update'
  delete '/cart/remove', to: 'cart#remove'
  delete '/cart/clear', to: 'cart#clear'

  # Orders and checkout
  resources :orders, only: [:index, :show, :new, :create]

  # Speaking bookings
  resources :bookings, only: [:new, :create]

  # Static pages
  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'
  post '/contact', to: 'pages#contact_submit'

  # Admin dashboard
  namespace :admin do
    root 'dashboard#index'
    resources :products do
      member do
        patch :update_image
      end
    end
    resources :categories
    resources :orders, only: [:index, :show, :update]
    resources :users, only: [:index, :show]
    resources :bookings, only: [:index, :show]

    # Content management
    get '/content', to: 'content#index'
    get '/content/edit_about', to: 'content#edit_about'
    patch '/content/update_about', to: 'content#update_about'
    get '/content/edit_contact', to: 'content#edit_contact'
    patch '/content/update_contact', to: 'content#update_contact'
  end
end
