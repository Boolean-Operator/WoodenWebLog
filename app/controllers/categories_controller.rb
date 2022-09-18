class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update]
  before_action :require_admin, except: [:index, :show]
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new()
  end

  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 5) 
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "The category information has been updated successfully"
      redirect_to category_path(@category)
    else
      render 'edit'
    end

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

  def set_category
    @category = Category.find(params[:id])
  end
  
  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "This action is only available to admin level users."
      redirect_to categories_path
    end
  end

  def category_params
    params.required(:category).permit(:name)
  end

end