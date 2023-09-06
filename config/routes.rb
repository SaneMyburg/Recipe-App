Rails.application.routes.draw do
  devise_for :users

  root 'recipes#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'public_recipes', to: 'recipes#index', as: 'public_recipes'
end
