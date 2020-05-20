Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end

  resources :contents
  delete "contents" => "contents#select_destroy"
end
