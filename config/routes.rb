# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations'
  }

  resources :users, only: %i[show edit update index] do
    member do
      get 'followers'
      get 'followings'
    end
    resource :relationships, only: %i[create destroy]
    resource :rooms, only: %i[show] do
      resources :chats, only: %i[create]
    end
  end

  resources :books do
    resource :favorites, only: %i[create destroy]
    resources :book_comments, only: %i[create]
  end

  resources :book_comments, only: %i[destroy]
  resources :chats, only: %i[destroy]

  root 'home#top'
  get 'home/about'
  get 'search' => 'searchs#search', as: 'search'
  patch 'map_display' => 'users#map_display', as: 'map_display'
end
