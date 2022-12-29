Rails.application.routes.draw do
  get 'cart/show'
  get 'order/home'
  get 'order/cart'
  root "home#index"
  get 'user_sign_up', to:"user#sign_up"
  post 'user_sign_up', to: "user#create"
  get 'user_login', to:"user#login"
  post 'user_login', to:"user#login"
  get "user_log_out", to:"user#logout"
  get "home", to: "home#index"
  get 'order/cart'
  get 'order/success'
  resources :items
  resources :products
  get 'home/index'
  get "admin_login", to:'admin#login'
  post "admin_login", to:'admin#login'
  get "admin_home", to:'admin#home'
  get "admin_order_history", to:"admin#order_history"
  get "admin_log_out", to:"admin#logout"
  get "user_addproduct", to:"user#add_product"
  get "cart_show", to:"cart#show"
  post "cart", to:"cart#save"
  get "checkout", to:"cart#checkout"
  post "checkout", to:"cart#checkout"
  get "purchase_complete", to:"cart#purchase_complete"
  get "user_order_history", to:"user#user_order_history"
  get "user_home" , to:"user#home"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
