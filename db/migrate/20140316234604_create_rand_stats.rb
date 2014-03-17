class CreateRandStats < ActiveRecord::Migration
  def change
    create_table :rand_stats do |t|
      t.integer :user_id

      t.integer :num
      t.string :ip
      t.datetime :j_time

      t.timestamps
    end
    add_index :rand_stats, :num
    add_index :rand_stats, :user_id
  end
end
