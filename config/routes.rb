Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  get 'persons/profile', as: 'user_root'
  
  resources :articles do
    resources :comments
  end

  root 'home#index'
end
