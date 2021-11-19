class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @groups = current_user.categories.includes(:treaties)
  end

  def new
    @group = Category.new
  end

  def show
    @group = Category.find(params[:id])
    @treaties = @group.treaties.includes(:user)
  end

  def create
    @group = Category.new(category_params)
    current_user.categories << @group
    if @group.save
      flash[:notice] = 'Category created successfully'
      redirect_to categories_path
    else
      flash[:alert] = 'Something went wrong'
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
