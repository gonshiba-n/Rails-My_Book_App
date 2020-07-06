Rails.application.routes.draw do
  devise_scope :user do
    root "devise/registrations#new"
  end

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
    get "users" => "users/registrations#edit"
  end

  resources :users, only: [:show, :edit, :update] do
    resources :contents
    delete "contents" => "contents#select_destroy", as: 'select_destroy'
  end
end
