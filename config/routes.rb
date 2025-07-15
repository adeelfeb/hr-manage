Rails.application.routes.draw do
  get "about",    to: "pages#about_us",  as: :about
  get "contact",  to: "pages#contact_us", as: :contact
  get "sign-up",  to: "pages#sign_up",    as: :sign_up
  get "login",    to: "pages#login",      as: :login



  resources :employees, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  get "/home" => "home#index"
  # get "home/index", to: "home#index"




  # Defines the root path route ("/")
  root "home#index"
end
