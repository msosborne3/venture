Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'welcome#home'

  resources :entries
  resources :users

  post '/users/:id/follow_user', to: 'relationships#follow_user', as: :follow_user
  post '/users/:id/unfollow_user', to: 'relationships#unfollow_user', as: :unfollow_user

  resources :comments

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
