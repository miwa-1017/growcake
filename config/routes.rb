Rails.application.routes.draw do
  get 'homes/top'
  get 'homes/about'
  root to: 'homes#top'
  get 'about' => 'homes#about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
