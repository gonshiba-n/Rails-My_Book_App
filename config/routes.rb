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
    get "other_user", to: "users#other_user", as: 'other_user'
    get "following_users", to: "users#following_users", as: 'following_users'
    get "follower_users", to: "users#follower_users", as: 'follower_users'
    resources :contents
    delete "contents" => "contents#select_destroy", as: 'select_destroy'
  end

  resources :time_line, only: [:index, :show]
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
end
