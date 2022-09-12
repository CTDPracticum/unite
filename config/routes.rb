Rails.application.routes.draw do
   resources :users
   get 'login', to: 'sessions#new'
   post 'login', to: 'sessions#create'
   get 'welcome', to: 'sessions#welcome'
   get 'authorized', to: 'sessions#page_requires_login'

   resources :groups do
      get 'join', on: :member
   end
   resources :meetups
   resources :sessions
   root to: 'users#new'
end
#   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html