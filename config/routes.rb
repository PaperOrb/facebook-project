Rails.application.routes.draw do
  devise_for :users
  resources :users, :comments, :friendships, :posts
  post '/friendship/confirm_friend', to: 'friendships#confirm_friend'
  devise_scope :user do
    root "devise/sessions#new"
  end
end
