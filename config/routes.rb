Rails.application.routes.draw do

  resources :meetings
  get 'errors/not_found'

  resources :industries

  get 'placement_dashboard/preservice_teacher'
  get 'placement_dashboard/industry'
  get 'placement_dashboard', to: "getting_started#welcome"

  get 'getting_started/welcome'
  get 'contact_database/interface'

  get 'realtime/answers'

  get 'answers/export/:id', to: "answers#export"
  post 'answers/export/:id', to: "answers#export"
  get 'answers', to: "answers#index"
  get 'answers/index'
  post 'answers/update'
  get 'answers/check'
  get 'answers/:id', to: "answers#show"

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
  get 'usertools/import'
  post 'usertools/importer'
  get 'usertools/new'
  post 'usertools/create'
  post 'usertools/update'
  get 'usertools/manage'
  post 'usertools/place/:industry_id', to: "usertools#addplacement"
  delete 'usertools/:id', to: "usertools#destroy"
  get 'usertools/:id', to: "usertools#edit"

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

  unless Rails.application.config.consider_all_requests_local
    # having created corresponding controller and action
    get '*not_found', to: 'errors#not_found'
  end
end
