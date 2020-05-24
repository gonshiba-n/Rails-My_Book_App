Rails.application.routes.draw do

  root 'tops#index'

  get 'tops/index'
  get 'tops/about'
  get 'tops/form'
  namespace :admin do
    resources :users
  end

  resources :contents
  delete "contents" => "contents#select_destroy", as: 'select_destroy'
end
