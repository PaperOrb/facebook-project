Rails.application.routes.draw do
  devise_for :users
  resources :users, :comments, :friendships, :posts
  devise_scope :user do
    root "devise/sessions#new"
  end
end
