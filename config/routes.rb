Rails.application.routes.draw do
  get 'entries/index'

  get 'entries/show'

  get 'entries/new'

  get 'entries/create'

  get 'entries/edit'

  get 'entries/update'

  get 'entries/destroy'

  devise_for :users
  root 'welcome#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
