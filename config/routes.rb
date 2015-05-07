# == Route Map
#
#                  Prefix Verb   URI Pattern                             Controller#Action
#                   about GET    /about(.:format)                        static_pages#about
#                 contact GET    /contact(.:format)                      static_pages#contact
#                     lab GET    /lab(.:format)                          static_pages#lab
#                  signup GET    /signup(.:format)                       users#new
#                   login GET    /login(.:format)                        sessions#new
#                         POST   /login(.:format)                        sessions#create
#                  logout DELETE /logout(.:format)                       sessions#destroy
#              microposts GET    /microposts(.:format)                   static_pages#home
#          following_user GET    /users/:id/following(.:format)          users#following
#          followers_user GET    /users/:id/followers(.:format)          users#followers
#                   users GET    /users(.:format)                        users#index
#                         POST   /users(.:format)                        users#create
#                new_user GET    /users/new(.:format)                    users#new
#               edit_user GET    /users/:id/edit(.:format)               users#edit
#                    user GET    /users/:id(.:format)                    users#show
#                         PATCH  /users/:id(.:format)                    users#update
#                         PUT    /users/:id(.:format)                    users#update
#                         DELETE /users/:id(.:format)                    users#destroy
#                         GET    /users(.:format)                        users#index
#                         POST   /users(.:format)                        users#create
#                         GET    /users/new(.:format)                    users#new
#                         GET    /users/:id/edit(.:format)               users#edit
#                         GET    /users/:id(.:format)                    users#show
#                         PATCH  /users/:id(.:format)                    users#update
#                         PUT    /users/:id(.:format)                    users#update
#                         DELETE /users/:id(.:format)                    users#destroy
# edit_account_activation GET    /account_activations/:id/edit(.:format) account_activations#edit
#         password_resets POST   /password_resets(.:format)              password_resets#create
#      new_password_reset GET    /password_resets/new(.:format)          password_resets#new
#     edit_password_reset GET    /password_resets/:id/edit(.:format)     password_resets#edit
#          password_reset PATCH  /password_resets/:id(.:format)          password_resets#update
#                         PUT    /password_resets/:id(.:format)          password_resets#update
#                         POST   /microposts(.:format)                   microposts#create
#               micropost DELETE /microposts/:id(.:format)               microposts#destroy
#           relationships POST   /relationships(.:format)                relationships#create
#            relationship DELETE /relationships/:id(.:format)            relationships#destroy
#                    root GET    /                                       static_pages#home
#

Rails.application.routes.draw do

  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'lab'     => 'static_pages#lab'

  get    'signup'  => 'users#new'        # show signup form

  get    'login'   => 'sessions#new'     # show login form
  post   'login'   => 'sessions#create'  # create a new session
  delete 'logout'  => 'sessions#destroy' # delete a session

  # To avoid error caused by paginating from Microposts controller.
  get    'microposts' => 'static_pages#home'

  # To add following and followers actions to the Users controller.
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]

  root            to: 'static_pages#home'
end
