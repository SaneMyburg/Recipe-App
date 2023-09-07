Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    resources :recipes, only: [:index, :show, :new, :create, :destroy]
    resources :foods, only: [:index, :new, :create, :destroy]
  end
  root 'foods#index'
  get 'public_recipes', to: 'recipes#index', as: 'public_recipes'
end
