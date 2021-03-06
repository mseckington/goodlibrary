class Loan < ActiveRecord::Base

  belongs_to :book
  belongs_to :user

  validates :book_id, :user_id, presence: true

  scope :active, -> { where(in_date: nil) }

  class << self
    def lend(book, user)
      find_or_create_by!(book: book, user: user, out_date: Date.today, in_date: nil)
    end

    def lended_to?(book, user)
      return false if book.nil? || user.nil?
      where(book_id: book.id, user_id: user.id, in_date: nil).present?
    end

    def on_loan?(book)
      return false if book.nil?
      where(book_id: book.id, in_date: nil).present?
    end

    def return_loan(book, user)
      loan = find_by(book: book, user: user, in_date: nil)
      loan.update_attributes!(in_date: Date.today)
    end
  end
end
