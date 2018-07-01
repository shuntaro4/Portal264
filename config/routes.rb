Rails.application.routes.draw do
  resources :concerts do
    resources :reservations, except: [:show]
  end
  devise_for :users, skip: [:password, :registrations]
  root to: 'welcome#index'
end
