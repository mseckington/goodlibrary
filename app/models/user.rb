class User < ActiveRecord::Base
  has_many :loans
  has_many :books, -> {merge(Loan.active) }, through: :loans

  validates :email, :presence => true, :uniqueness => true, :email => true, :length => { :maximum => 191 }
  validates :first_name, :presence => true, length: { maximum: 255 }
  validates :last_name, :presence => true, length: { maximum: 255 }

  has_secure_password

  class << self
    def authenticate(email, password)
      user = User.find_by_email(email)
      return nil unless user
      user.authenticate(password) ? user : nil
    end
  end

  def full_name
    [first_name, last_name].join(' ')
  end
end
