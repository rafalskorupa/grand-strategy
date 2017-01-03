Rails.application.routes.draw do


  resources :states
  resources :populations
  resources :provinces
  resources :cultures
  resources :states

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
