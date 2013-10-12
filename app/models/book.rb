class Book < ActiveRecord::Base

  validates :title, :author, :image_url, :goodreads_url, presence: true

  scope :with_image, -> { where('image_url is NOT ?', 'https://www.goodreads.com/assets/nocover/111x148.png') }
  scope :in_series_alphabetical_order, -> { order(:series) }
end
