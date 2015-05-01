Rails.application.routes.draw do

  root                'static_pages#home'

  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'lab'     => 'static_pages#lab'

  get    'signup'  => 'users#new'        # show signup form

  get    'login'   => 'sessions#new'     # show login form
  post   'login'   => 'sessions#create'  # create a new session
  delete 'logout'  => 'sessions#destroy' # delete a session

  # To avoid error caused by paginating from MicropostsController.
  get    'microposts' => 'static_pages#home'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
end
