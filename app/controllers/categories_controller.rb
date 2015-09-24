class CategoriesController < ApplicationController
  def show
    
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    
  end
end
