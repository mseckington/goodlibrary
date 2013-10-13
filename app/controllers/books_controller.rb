class BooksController < ApplicationController

  def index
    @books = Book.with_image.in_series_alphabetical_order.all
  end

  def show
    @book = Book.find_by_id(params[:id])
  end

  def my_loans
    if signed_in?
      @books = current_user.books
      render 'index'
    else
      redirect_to sign_in_path
    end
  end
end
