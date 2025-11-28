Rails.application.routes.draw do
  devise_for :users
  get 'homes/top'
  get 'homes/about'
  root to: 'homes#top'
  get 'about' => 'homes#about'
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
end
