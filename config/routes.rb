Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    resources :recipes, only: [:index, :new, :create, :destroy]
  end

  root 'recipes#index'
end
