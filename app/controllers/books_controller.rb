class BooksController < ApplicationController

  def index
    @books = Book.with_image.all
  end
end
