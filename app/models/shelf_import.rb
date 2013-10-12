require 'faraday'
require 'faraday_middleware'
require 'nokogiri'

class ShelfImport

  def initialize

  end

  def get_shelf
    response = connection.get "/review/list/1222242.xml?key=5pYuYZCH0Glr3oTM9nfwow&v=2&id=1222242&shelf=my-library&per_page=200"
    Nokogiri::XML(response.body).search('book').each do |book_data|
      book = Book.new(
        title: book_data.search('title').text,
        author: book_data.search('author name').first.text,
        image_url: book_data.search('image_url').first.text,
        goodreads_url: book_data.search('link').text,
        isbn: book_data.search('isbn').text,
        isbn13: book_data.search('isbn13').text,
        num_pages: book_data.search('num_pages').text,
        format: book_data.search('format').text,
        description: book_data.search('description').text,
        publisher: book_data.search('publisher').text
      )
      book.save!
    end
  end

  def connection
    @connection ||= Faraday.new(url: 'https://www.goodreads.com') do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

end
