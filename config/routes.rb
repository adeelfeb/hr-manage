Rails.application.routes.draw do
  
  # devise_for :users
  devise_for :users, controllers: {
  sessions: 'users/sessions',
  registrations: 'users/registrations',
  passwords: 'users/passwords'
}


  # resources :projects
  resources :projects do
    resources :bugs
  end




  get "about",    to: "pages#about_us",  as: :about
  get "contact",  to: "pages#contact_us", as: :contact
  get "sign-up",  to: "pages#sign_up",    as: :sign_up
  get "login",    to: "pages#login",      as: :login


  get "/home" => "home#index"
  # get "home/index", to: "home#index"




  # Defines the root path route ("/")
  root "home#index"
end
