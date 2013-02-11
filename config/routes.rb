Petitions::Application.routes.draw do
  root to: 'sessions#new'
  get 'signin' => "sessions#new"
  post 'signin' => "sessions#create"
  get 'signout' => "sessions#destroy"

  resources :petitions, only: [:index, :show]

  namespace :admin do
    resources :petitions, except: [:show]
  end
end
