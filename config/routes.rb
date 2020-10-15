Rails.application.routes.draw do
  devise_for :users
  post '/friendship/confirm_friend/:id', to: 'friendships#confirm_friend'  # adding :id segment to these causes undefined method friendship_confirm_friend_path. i suspect passing a valid object to the helper would shut it up. what's valid tho?
  get '/friendship/remove_friend/:id', to: 'friendships#remove_friend'
  resources :users, :comments, :friendships, :posts


  devise_scope :user do
    root "devise/sessions#new"
  end
end
