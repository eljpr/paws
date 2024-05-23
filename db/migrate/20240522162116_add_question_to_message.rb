class AddQuestionToMessage < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :question, :text
  end
end
