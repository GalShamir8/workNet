Rails.application.routes.draw do
  resources :posts
  resources :links, only: %w[new create index destroy]
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, only: %w[index show]

  patch 'posts/:id/like', to: 'posts#like', as: 'post_like'
  post 'posts/:id/post_comments', to: 'posts#post_comments', as: 'post_comments'
  get 'static_pages/privacy_policy', to: 'static_pages#privacy_policy'
  root 'posts#index'
end
