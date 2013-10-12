# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book do
    title "MyString"
    image_url "MyString"
    goodreads_url "MyString"
    isbn "MyString"
    isbn13 "MyString"
    num_pages 1
    format "MyString"
    publisher "MyString"
    description "MyText"
    author "MyString"
    rating 1
  end
end
