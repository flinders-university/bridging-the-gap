Rails.application.routes.draw do
  
  resources :groups do
    post "add_user"
  end

  devise_for :users, :controllers => { registrations: 'registrations' }

  get 'getting_started/information'

  resources :pages

  root "getting_started#information"
end
