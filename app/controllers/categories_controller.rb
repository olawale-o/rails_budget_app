class CategoriesController < ApplicationController
  def index
    @groups = current_user.groups.includes(:treaties)
  end
end
