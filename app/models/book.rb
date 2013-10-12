class Book < ActiveRecord::Base

  validates :title, :author, :image_url, :goodreads_url, presence: true
end
