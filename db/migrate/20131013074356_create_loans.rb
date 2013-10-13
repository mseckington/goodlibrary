class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.integer :book_id
      t.integer :user_id
      t.date :out_date
      t.date :in_date

      t.timestamps
    end
  end
end
