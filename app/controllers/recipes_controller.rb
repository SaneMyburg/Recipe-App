class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = (current_user.recipes.includes(:user) if user_signed_in?)
    @recipes = @recipes.order(created_at: :desc)
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods.includes(:food)
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    @recipe.public = false

    if @recipe.save
      redirect_to recipes_path, notice: 'Recipe created successfully.'
    else
      render :new
    end
  end

  def destroy
    @recipe = current_user.recipes.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path, notice: 'Recipe deleted successfully.'
  end

  def public_recipes
    @recipes = Recipe.public_recipes.includes(:user)
  end

  def make_public
    @recipe = current_user.recipes.find(params[:id])
    @recipe.update(public: true)
    redirect_to @recipe, notice: 'Recipe is now public.'
  end

  def make_private
    @recipe = current_user.recipes.find(params[:id])
    @recipe.update(public: false)
    redirect_to @recipe, notice: 'Recipe is now private.'
  end

  def shopping_list
    @recipes = current_user.recipes.includes(:recipe_foods)
    @missing_foods = find_missing_foods
    @total_items = @missing_foods.pluck(:quantity).sum
    @total_price = calculate_total_price(@missing_foods)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :public, :description)
  end

  def find_missing_foods
    missing_foods = []
    @recipes.each do |recipe|
      recipe.recipe_foods.each do |recipe_food|
        missing_quantity = recipe_food.quantity
        missing_foods << recipe_food if missing_quantity&.positive?
      end
    end
    missing_foods
  end

  def calculate_total_price(missing_foods)
    total_price = 0
    missing_foods.each do |recipe_food|
      total_price += recipe_food.quantity * recipe_food.food.price
    end
    total_price
  end
end
