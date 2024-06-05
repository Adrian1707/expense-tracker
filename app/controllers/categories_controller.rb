class CategoriesController < ApplicationController
  def index
    @categories = Category.pluck(:title)
  end
end
