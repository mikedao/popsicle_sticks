class AddEnabledToStudents < ActiveRecord::Migration[7.0]
  def change
    add_column :students, :enabled, :boolean
  end
end
