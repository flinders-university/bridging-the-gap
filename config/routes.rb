Rails.application.routes.draw do

  get 'celebration', to: "celebration#indexsixteen"
  post 'celebration', to: "celebration#save"

  resources :unit_presentations

  resources :industry_presentations

  resources :focus_groups do
    post "register"
  end

  get 'certificates/conference' => "certificates#conference"

  get 'conference_management/index'
  patch 'conference_management/update'
  get 'conference_management/pst'
  get 'conference_management/name_badges'
  get 'conference_management/sign_in_sheet'
  get 'conference_management/export'
  delete 'conference_management/destroy'
  delete 'conference_management/destroy_pst'

  resources :project_teams

  resources :fg_bookings

  get 'navigation_map', to: 'navigation_map#index'

  get 'tracking/students'

  resources :research_scientists
  resources :student_groups
  resources :student_blogs do
    collection { get "report" }
  end
  resources :tasks

  resources :meetings

  get 'errors/not_found'

  resources :industries do
    collection { get "report" }
  end

  get 'placement_dashboard/preservice_teacher'
  get 'placement_dashboard/industry'
  get 'placement_dashboard', to: "getting_started#welcome"

  get 'getting_started/welcome'
  get 'getting_started/mark_task_complete'
  get 'teacher_conference', to: "getting_started#teacher_conference"
  post 'register_for_teacher_conference', to: "getting_started#tc_register"
  post 'teacher_conference/change_interest', to: "getting_started#mod_interest"
  get 'teacher_conference/registration', to: "getting_started#view_registration"
  patch 'update_teacher_conference_registration', to: "getting_started#update_registration"

  get 'contact_database/interface'

  get 'realtime/answers'

  get 'answers/export/:id', to: "answers#export"
  post 'answers/export/:id', to: "answers#export"
  get 'answers', to: "answers#index"
  get 'answers/htmlreport/:id', to: "answers#htmlreport"
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

  devise_for :users, :controllers => { registrations: 'registrations', confirmations: 'confirmations', sessions: 'sessions' }

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
