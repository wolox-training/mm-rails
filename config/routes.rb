Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  mount_devise_token_auth_for 'User', at: 'users'
  get '/users/me', to: 'users#me'
  resources :users, only: %i[index show] do
    resources :rents, only: %i[index create]
  end
  resources :books, only: %i[index show]
  resources :book_suggestions, only: :create
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
