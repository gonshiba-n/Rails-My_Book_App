Rails.application.routes.draw do

  devise_scope :user do
    root "devise/registrations#new"
  end
  devise_for :users, :controllers => {
    :registrations => 'registrations'
  }

  resources :users, only: [:edit, :update]

  resources :contents
  delete "contents" => "contents#select_destroy", as: 'select_destroy'
end
