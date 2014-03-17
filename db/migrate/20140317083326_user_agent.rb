class UserAgent < ActiveRecord::Migration
  def change
    add_column :rand_stats, :user_agent, :string
  end
end
