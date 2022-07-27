class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :name
      t.string :pronouns
      t.integer :called_on_count
      t.references :mod, foreign_key: true

      t.timestamps
    end
  end
end
