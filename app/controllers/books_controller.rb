class BooksController < ApplicationController

  def index
    @books = Book.with_image.in_series_alphabetical_order.all
  end

  def show
    @book = Book.find_by_id(params[:id])
  end
end
