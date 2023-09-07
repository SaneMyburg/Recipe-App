Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    resources :recipes, only: [:index,:show, :new, :create, :destroy]
  end

  root 'recipes#index'
end
