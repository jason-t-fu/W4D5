Rails.application.routes.draw do
  resource :session, only: [:new, :create, :delete]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :show, :index]
end
