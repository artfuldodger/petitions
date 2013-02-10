Petitions::Application.routes.draw do
  root to: 'sessions#new'
  get 'signin' => "sessions#new"
  post 'signin' => "sessions#create"
  get 'signout' => "sessions#destroy"

  namespace :admin do
    resources :petitions
  end
end
