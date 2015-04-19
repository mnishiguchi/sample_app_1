Rails.application.routes.draw do

  get 'password_resets/new'

  get 'password_resets/edit'

  root                'static_pages#home'

  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'help'    => 'static_pages#help'

  get    'signup'  => 'users#new'        # show signup form

  get    'login'   => 'sessions#new'     # show login form
  post   'login'   => 'sessions#create'  # create a new session
  delete 'logout'  => 'sessions#destroy' # delete a session

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
end
