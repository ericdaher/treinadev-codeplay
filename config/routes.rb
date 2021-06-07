Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  namespace :admin do
    root 'home#index'
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

  namespace :api do
    namespace :v1 do
      resources :courses, only: %i[index show create], param: :code
    end
  end
end
