class AddUserId < ActiveRecord::Migration[7.1]
  def change
    add_reference :walks, :user, foreign_key: true
  end
end
