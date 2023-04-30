Rails.application.routes.draw do
  resources :posts
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users

  post 'posts/:id/like', to: 'posts#like', as: 'post_like'
  root 'posts#index'
end
