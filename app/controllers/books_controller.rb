class BooksController < ApplicationController

  def index
    @books = Book.with_image.all
  end

  def show
    @book = Book.find_by_id(params[:id])
  end
end
