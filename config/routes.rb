Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'welcome#home'

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

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
