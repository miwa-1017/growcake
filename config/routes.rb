Rails.application.routes.draw do
  devise_for :users, controllers: {
  registrations: 'users/registrations'
}

  get 'homes/top'
  root to: 'homes#top'
  get 'about' => 'homes#about'

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  authenticate :user do
    get '/mypage', to: 'users#show', as: 'mypage'
  end

  resources :users, only: [:show]  
  resources :posts
  resources :exercise_logs, only: [:index, :new, :create]
end
