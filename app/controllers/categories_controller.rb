class CategoriesController < ApplicationController
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new()
  end

  def show
    @category = Category.find_by(params[:id])

  end

  def create
    @category = Category.new(category_parmas)
    if @category.save
      flash[:notice] = "Category was created successfully"
      redirect_to @category
    else
      render 'new'
    end
  end

  private

  def category_parmas
    params.required(:category).permit(:name)
  end

end