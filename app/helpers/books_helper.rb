module BooksHelper
  def book_image_tag(book, css_class = nil)
    image_tag book.image_url, alt: book.title, title: book.title, class: css_class
  end
end
