class CategoriesController < ApplicationController
  def index
    @groups = current_user.groups.includes(:treaties)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(category_params)
    current_user.groups << @group
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
    params.require(:group).permit(:name, :icon)
  end
end
