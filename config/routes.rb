TecheventsIe::Application.routes.draw do
  resources :venues, only: []
  resources :events, path: '', only: [:index, :show]
  devise_for :users

  root :to => 'events#index'
end
