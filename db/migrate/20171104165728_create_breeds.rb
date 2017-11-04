class CreateBreeds < ActiveRecord::Migration[5.1]
  def change
    create_table :breeds do |t|
      t.string :name, unique: true, present: true
      t.timestamps

      t.index :id
      t.index :name
    end
  end
end
