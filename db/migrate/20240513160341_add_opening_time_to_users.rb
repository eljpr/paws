class AddOpeningTimeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :opening_time, :time
  end
end
