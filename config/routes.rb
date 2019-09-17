# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  resources :larps
  resources :larps, only: [:edit] do
    member do
      patch "assign_character" => "characters#assign"
      patch "unassign_character" => "characters#unassign"
    end
  end

  resources :characters
  resources :addresses
  resources :users, only: [:edit, :update, :show]

  get "/auth/:provider/callback" => "authentications#create"
end
