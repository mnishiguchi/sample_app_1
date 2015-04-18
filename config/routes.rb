Rails.application.routes.draw do

  get 'account_activations/edit'

  root                'static_pages#home'

  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'help'    => 'static_pages#help'

  get    'signup'  => 'users#new'        # show signup form

  get    'login'   => 'sessions#new'     # show login form
  post   'login'   => 'sessions#create'  # create a new session
  delete 'logout'  => 'sessions#destroy' # delete a session

  resources :users
end
