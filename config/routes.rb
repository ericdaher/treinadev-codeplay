Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  namespace :admin do
    resources :courses do
      resources :lessons, only: %i[show new create]
    end
    resources :instructors
  end

  resources :courses, only: %i[index show] do 
    resources :lessons, only: %i[show]
    post 'enroll', on: :member
    get 'mine', on: :collection
  end
  resources :instructors, only: %i[index show]
end
