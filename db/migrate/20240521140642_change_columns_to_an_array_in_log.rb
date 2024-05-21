class ChangeColumnsToAnArrayInLog < ActiveRecord::Migration[7.1]
  def change
    change_column :logs, :food, :text, array: true, default: [], using: "(string_to_array(food, ','))"
    change_column :logs, :medication, :text, array: true, default: [], using: "(string_to_array(medication, ','))"
    change_column :logs, :special_treat, :text, array: true, default: [], using: "(string_to_array(special_treat, ','))"
    change_column :logs, :grooming, :text, array: true, default: [], using: "(string_to_array(grooming, ','))"
    change_column :logs, :stool, :text, array: true, default: [], using: "(string_to_array(stool, ','))"
    change_column :logs, :vaccination, :text, array: true, default: [], using: "(string_to_array(vaccination, ','))"
    change_column :logs, :mood, :text, array: true, default: [], using: "(string_to_array(mood, ','))"
    change_column :logs, :energy, :text, array: true, default: [], using: "(string_to_array(energy, ','))"
    change_column :logs, :training, :text, array: true, default: [], using: "(string_to_array(training, ','))"
  end
end
