class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = current_user.foods
  end

  def new
    @food = Food.new
  end

  def create
    @food = current_user.foods.build(food_params)

    existing_food = current_user.foods.find_by(name: @food.name)

    if existing_food
      flash.now[:alert] = 'A food with this name already exists.'
      render :new
    elsif @food.save
      redirect_to foods_path, notice: 'Food was successfully created.'
    else
      flash.now[:alert] = 'Food creation failed. Please check the form for errors.'
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_path, notice: 'Food was successfully deleted.'
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price)
  end
end
