Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    root 'foods#index', as: :authenticated_root
    resources :foods, only: [:index, :new, :create, :destroy]
    resources :recipes, only: [:index, :show, :new, :create, :destroy] do
      member do
        put :make_public
        put :make_private
        get 'shopping_list'
      end
      resources :foods, only: [:new, :create]
      resources :recipe_foods, only: [:new, :create, :destroy]
    end
    get 'public_recipes', to: 'recipes#public_recipes', as: 'public_recipes'
  end
end
