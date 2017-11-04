class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :name, unique: true, present: true
      t.timestamps

      t.index :id
      t.index :name
    end
  end
end
