Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'sessions'
  resource :users, only: [:index, :show, :create, :update]
  get '/users/me', to: 'users#me'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
