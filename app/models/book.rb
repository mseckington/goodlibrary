class Book < ActiveRecord::Base

  validates :title, :author, :image_url, :goodreads_url, presence: true

  has_many :loans, dependent: :destroy
  has_many :users, through: :loans

  scope :with_image, -> { where('image_url is NOT ?', 'https://www.goodreads.com/assets/nocover/111x148.png') }
  scope :in_series_alphabetical_order, -> { order('series IS NULL ASC, series ASC') }
  scope :unavailable, -> { includes(:loans).where('loans.out_date is NOT NULL').references(:loans)}
  scope :available, -> { where("id not IN (?)", Loan.active.collect(&:book_id))}

  def available?
    !Loan.on_loan?(self)
  end
end
