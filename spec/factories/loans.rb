# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :loan, :class => 'Loan' do
    book_id 1
    user_id 1
    out_date "2013-10-13"
    in_date "2013-10-13"
  end
end
