Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "user/omniauth_callbacks", registrations: 'registrations' }
  root 'places#index'

  resources :entries do
    resources :comments
  end
  resources :users
  resources :places do
    resources :posts
  end

  post '/users/:id/follow_user', to: 'relationships#follow_user', as: :follow_user
  post '/users/:id/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user
  get '/users/:id/following', to: 'users#following', as: :following
  get '/users/:id/followers', to: 'users#followers', as: :followers
  get '/users/:id/journal', to: 'users#journal', as: :journal
  get '/search', to: 'search#search', as: :search
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
