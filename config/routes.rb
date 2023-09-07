Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    resources :recipes, only: [:index,:show, :new, :create, :destroy]
  end

  # Defines the root path route ("/")
  # root "articles#index"
  get 'public_recipes', to: 'recipes#index', as: 'public_recipes'
  root 'recipes#index'
end
