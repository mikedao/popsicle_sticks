class CreateMods < ActiveRecord::Migration[7.0]
  def change
    create_table :mods do |t|
      t.string :number
      t.string :program

      t.timestamps
    end
  end
end
