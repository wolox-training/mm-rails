class RenameRentsColumnsNames < ActiveRecord::Migration[5.1]
  def change
    rename_column :rents, :from, :starting_date
    rename_column :rents, :to, :ending_date
  end
end
