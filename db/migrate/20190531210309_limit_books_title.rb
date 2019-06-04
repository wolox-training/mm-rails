class LimitBooksTitle < ActiveRecord::Migration[5.1]
  def up
    change_column :books, :title, :string, limit: 25
  end

  def down
    change_column :books, :title, :string, limit: nil
  end
end
