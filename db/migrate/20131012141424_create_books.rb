class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :image_url
      t.string :goodreads_url
      t.string :isbn
      t.string :isbn13
      t.integer :num_pages
      t.string :format
      t.string :publisher
      t.text :description
      t.string :author
      t.integer :rating
      t.string :series

      t.timestamps
    end
  end
end
