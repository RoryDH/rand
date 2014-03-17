class AddIndexOfNumber < ActiveRecord::Migration
  def change
    add_column :rand_stats, :list_index, :integer
    add_index :rand_stats, :list_index
  end
end
