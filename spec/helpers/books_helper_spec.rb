require 'spec_helper'

describe BooksHelper do
  describe 'book_image_tag' do
    let(:book) { double(:book, image_url: '/image.jpg', title: 'book-title') }

    it 'fetches image' do
      book.stub(:image_url).and_return('/image.jpg')
      expect(helper.book_image_tag(book)).to have_css("img[src='/image.jpg']")
    end

    it 'gives the image a class if passed in' do
      expect(helper.book_image_tag(book, 'image-class')).to have_css("img.image-class")
    end

    it 'gives the image a title attribute' do
      expect(helper.book_image_tag(book)).to have_css("img[title='book-title']")
    end

    it 'gives the image an alt attribute' do
      expect(helper.book_image_tag(book)).to have_css("img[alt='book-title']")
    end
  end
end
