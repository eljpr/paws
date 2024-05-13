class AddLogDateToLogs < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :log_date, :date
  end
end
