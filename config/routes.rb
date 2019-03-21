Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    resources :comments, only: [:create, :destroy, :edit, :update]
  end
  
  root 'posts#index'
end
