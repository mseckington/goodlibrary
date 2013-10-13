require 'spec_helper'

describe Loan do
  it 'has a factory that builds a valid instance' do
    expect(FactoryGirl.build_stubbed(:loan)).to be_valid
  end

  describe 'validation' do
    let(:user) { FactoryGirl.build_stubbed(:user) }
    let(:book) { FactoryGirl.create(:book) }
    let(:loan) { Loan.new(user: user, book: book) }

    it 'succeeds with valid attributes' do
      expect(loan).to be_valid
    end

    it 'fails without an user' do
      loan.user = nil
      expect(loan).not_to be_valid
    end

    it 'fails without a book' do
      loan.book = nil
      expect(loan).not_to be_valid
    end
  end
end
