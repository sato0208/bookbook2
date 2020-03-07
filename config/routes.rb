Rails.application.routes.draw do
  # get 'users/show'
  devise_for :users #, controllers: {
  # 	sessions:      'users/sessions',
  #   passwords:     'users/passwords',
  #   registrations: 'users/registrations'
  #   }


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#show'

# 自動的にルーティングを設定してくれる
  resources :books, only: [:create, :index, :show, :new, :edit, :destroy, :update]
  resources :users, only: [:show, :edit, :update, :new, :index]
end
