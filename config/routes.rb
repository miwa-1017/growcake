Rails.application.routes.draw do
  get 'invite/index'
  get 'notifications/index'
  get 'growth_records/index'
  #マイページ(一般ユーザー用)
  #get 'cake_types/edit'
  #get 'cake_types/update'
  devise_for :users, controllers: {
  registrations: 'users/registrations'
}
  root 'homes#top'
  get 'homes/top', to: 'homes#top'
  get 'about' => 'homes#about'

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  authenticate :user do
    get '/mypage', to: 'mypage#show', as: 'mypage'
    patch '/mypage', to: 'mypage#update'
  end

  get 'invite', to: 'invite#index'

  resources :users, only: [:show, :index, :edit, :update, :destroy] do
    member do
      get :following
      get :followers
      patch :withdraw
    end
  end

  resources :posts do
    collection do
      get :search
    end
    resources :comments, only: [:create, :destroy]
    resource :like, only: [:create, :destroy]
  end
  resources :likes, only: [:index]
  resources :relationships, only: [:create, :destroy]
  resources :exercise_logs, only: [:index, :new, :create]
  resources :growth_logs, only: [ :create]
  get '/growth', to: 'growth#show', as: :growth
  resources :growth,only: :show
  resource :cake_type, only:[:edit, :update]
  resource :mypage, only:[:show, :edit, :update]do
    delete :withdraw, to:"users#withdraw"
  end
  resources :growth_records, only:[:index, :create]
  resources :notifications, only: [:index, :show]

  #====管理者用==========
    namespace :admin do
    resources :users, only: [:index, :show, :destroy] do
      member do
        patch :withdraw
        patch :ban
        patch :unban
      end
    end 
    resources :comments, only: [:destroy]
  end
end
