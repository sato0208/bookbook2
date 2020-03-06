Rails.application.routes.draw do
  # get 'users/show'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'books#index'

  resources :books, only: [:create, :index, :show, :new, :edit, :destroy, :update]
  resources :users, only: [:show, :edit, :update]
end
