Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'sessions'
  get '/users', to: 'users#index'
  get '/users/me', to:'users#me'
  get '/users/:id', to: 'users#show'
  patch '/users/:id', to: 'users#update'
  post '/users', to: 'users#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
