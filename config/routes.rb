Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  mount_devise_token_auth_for 'User', at: 'users'
  get '/users/me', to: 'users#me'
  resources :users, only: %i[index show] do
    resources :rents, only: %i[index create]
  end
  resources :book_suggestions, only: :create
  resources :books, only: %i[index show] do
    collection do
      get :open_library_information
    end
  end
end
