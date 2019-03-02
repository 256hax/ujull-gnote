Rails.application.routes.draw do
  scope :comments do
    get ':message_id/new', to: 'comments#new', as: :new_comment
    post ':message_id', to: 'comments#create', as: :comment
    delete  ':id', to: 'comments#destroy'
  end

  resources  :messages do
    resources :likes, only: [:create]
  end

  #--- Static Pages ---
  %w(
    about
    howto
  ).each do | action |
    get "articles/#{action}", controller: 'static_pages', action: action
  end

  #--- Users ---
  namespace :users do
    get 'comments', to: 'comments#index', as: :comments
    get 'messages', to: 'messages#index', as: :messages
    get 'summaries', to: 'summaries#index', as: :summaries
  end

  devise_for :users, controllers: {registrations: "users/registrations"}

  root to: 'messages#index'
end
