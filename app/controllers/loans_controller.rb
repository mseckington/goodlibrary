class LoansController < ApplicationController
  include PayPal::SDK::REST
  before_filter :lookup_book

  def create
    if signed_in?
      if payment.create
        session[:payment_id] = payment.id
        session[:book_id] = @book.id
        redirect_to payment.links.find{|link| link.method == 'REDIRECT'}.href
      end
    else
      redirect_to sign_in_path
    end
  end

  def update
    return_payment = Payment.find session[:payment_id]
    if return_payment.execute payer_id: params['PayerID']
      loan = Loan.lend(@book, current_user)
      if loan.valid?
        redirect_to book_path(@book)
      else
        redirect_to root_path
      end
    end
  end

  def destroy
    Loan.return_loan(@book, current_user)
    redirect_to book_path(@book)
  end

  private

  def lookup_book
    @book = Book.find_by_id(params[:book_id] || session[:book_id])
  end

  def payment
    @payment ||= Payment.new({
      intent: 'authorize',
      payer: {
        payment_method: 'paypal'
      },
      redirect_urls: {
        return_url: "http://localhost:3000/books/#{@book.id}/loan",
        cancel_url: "http://localhost:3000/books/#{@book.id}/loan"
      },
      transactions: [
        {
          amount: {
            total: "5.00",
            currency: "GBP"
          },
          description: "Late fees for GoodLibrary"
        }
      ]
    })
  end
end
