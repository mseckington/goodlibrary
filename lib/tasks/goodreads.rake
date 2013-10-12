namespace :goodreads do
  desc "import my library shelf from goodreads"
  task import_shelf: :environment do
    Book.delete_all
    ShelfImport.new.get_shelf
  end
end

