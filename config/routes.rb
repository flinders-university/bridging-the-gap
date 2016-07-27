Rails.application.routes.draw do

  get 'realtime/answers'

  get 'answers', to: "answers#index"
  get 'answers/index'
  post 'answers/update'
  get 'answers/check'

  get 'toolbox/markdown'

  get 'illuminet/polymer'
  post 'illuminet', to: "illuminet#save"
  get 'illuminet/:id', to: "illuminet#take"
  get 'illuminet', to: "illuminet#polymer"

  resources :i_surveys
  resources :i_questions do
    delete "destroy_for"
  end
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

  # Cable Server
  mount ActionCable.server => "/cable"

  root "getting_started#information"
end
