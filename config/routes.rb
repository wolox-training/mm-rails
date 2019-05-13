Rails.application.routes.draw do
  resources :books
  mount_devise_token_auth_for 'User', at: 'users'
  get '/users/me', to: 'users#me'
  resources :users, only: %i[index show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
