Rails.application.routes.draw do
  devise_for :users
  root to: 'tv_schedules#index'
  resources :tv_schedules, only: :index do
    collection do
      get 'search'
    end
  end
end
