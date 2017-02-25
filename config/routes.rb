Rails.application.routes.draw do

  get 'posts/show'

  get 'posts/index'

  get 'posts/new'

  get 'posts/create'

  get 'posts/edit'

  get 'posts/update'

  get 'posts/destroy'

  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'welcome#home'

  resources :entries do
    resources :comments
  end
  resources :users
  resources :places

  post '/users/:id/follow_user', to: 'relationships#follow_user', as: :follow_user
  post '/users/:id/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user
  get '/users/:id/following', to: 'users#following', as: :following
  get '/users/:id/followers', to: 'users#followers', as: :followers

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
