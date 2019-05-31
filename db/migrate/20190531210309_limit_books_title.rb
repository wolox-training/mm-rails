class LimitBooksTitle < ActiveRecord::Migration[5.1]
  def up
    Book.where('length(title) > 25').find_each do |book|
      book.update title: book.title.first(22) + '...'
    end
    change_column :books, :title, :string, limit: 25
  end

  def down
    change_column :books, :title, :string, limit: nil
  end
end
