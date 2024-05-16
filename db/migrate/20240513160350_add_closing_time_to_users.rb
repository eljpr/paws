class AddClosingTimeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :closing_time, :time
  end
end
