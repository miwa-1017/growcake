Rails.application.routes.draw do
  #get 'cake_types/edit'
  #get 'cake_types/update'
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
    get '/mypage', to: 'mypage#show', as: 'mypage'
    get '/mypage/edit', to: 'mypage#edit', as: :edit_mypage
    patch '/mypage', to: 'mypage#update'
  end

  resources :users, only: [:show, :index, :destroy]  
  resources :posts
  resources :exercise_logs, only: [:index, :new, :create]
  resources :growth_logs, only: [ :create]
  get '/growth', to: 'growth#show', as: :growth
  resources :growth,only: :show
  resource :cake_type, only:[:edit, :update]
end
