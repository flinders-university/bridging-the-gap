Rails.application.routes.draw do

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
