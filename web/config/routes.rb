Rails.application.routes.draw do
  resources :posts
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users

  patch 'posts/:id/like', to: 'posts#like', as: 'post_like'
  get 'static_pages/privacy_policy', to: 'static_pages#privacy_policy'
  root 'posts#index'
end
