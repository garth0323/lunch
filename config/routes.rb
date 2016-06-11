Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :restaurants do
    member do
      post 'upvote'
      post 'downvote'
      post 'add_review'
    end
  end

  resources :groups do
    member do
      get 'restaurant'
      post 'choose_restaurant'
      post 'accept_invitation'
    end
  end


  # You can have the root of your site routed with "root"
  root 'pages#index'

end
