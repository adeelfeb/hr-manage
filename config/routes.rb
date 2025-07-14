Rails.application.routes.draw do
  get "pages/about_us"
  get "pages/contact_us"
  get "pages/sign_up"
  get "pages/login"
  

  get "/home" => "home#index"
  # get "home/index", to: "home#index"




  # Defines the root path route ("/")
  root "home#index"
end
