Rails.application.routes.draw do
  devise_for :users, skip: [:password, :registrations]
  root to: 'welcome#index'
end
