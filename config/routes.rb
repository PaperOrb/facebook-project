Rails.application.routes.draw do
  devise_for :users
  resources :users, :comments, :posts, defaults: { format: "html" }
  resources :friendships, only: [:index, :create], defaults: { format: "html" }
  post '/friendships/confirm_friend/:id', to: 'friendships#confirm_friend', as: :confirm_friend # adding :id segment to these causes undefined method friendship_confirm_friend_path. i suspect passing a valid object to the helper would shut it up. what's valid tho?
  delete '/friendships/remove_friend/:id', to: 'friendships#remove_friend', as: :remove_friend

  devise_scope :user do
    root "devise/sessions#new"
  end
end
