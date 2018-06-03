Rails.application.routes.draw do
  resources :concerts
  devise_for :users, skip: [:password, :registrations]
  root to: 'welcome#index'
end
