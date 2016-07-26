Rails.application.routes.draw do

  get 'toolbox/markdown'

  get 'illuminet/polymer'
  post 'illuminet', to: "illuminet#save"
  get 'illuminet/:id', to: "illuminet#take"
  get 'illuminet', to: "illuminet#polymer"

  resources :i_surveys
  resources :i_questions
  resources :documents
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

  resources :forms do
    get "signature_tree"
  end

  resources :blogs

  resources :groups do
    post "add_user"
  end

  devise_for :users, :controllers => { registrations: 'registrations' }

  get 'getting_started/information'

  resources :pages

  root "getting_started#information"
end
