Rails.application.routes.draw do

  resources :group_change_requests
  
  get 'usertools', to: 'usertools#manage'
  get 'usertools/search'
  post 'usertools/search'
  get 'usertools/new'
  get 'usertools/create'
  get 'usertools/update'
  get 'usertools/manage'

  post 'mailmerge/postmaster'
  get 'mailmerge/preview'

  resources :signatures

  resources :forms

  resources :blogs

  resources :groups do
    post "add_user"
  end

  devise_for :users, :controllers => { registrations: 'registrations' }

  get 'getting_started/information'

  resources :pages

  root "getting_started#information"
end
