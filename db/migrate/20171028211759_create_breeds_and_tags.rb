class CreateBreedsAndTags < ActiveRecord::Migration[5.1]
  def change
    create_table :breeds do |t|
      t.string :name, unique: true, present: true
      t.timestamps
    end

    create_table :tags do |t|
      t.string :name, unique: true, present: true
      t.timestamps
    end

    create_join_table :breeds, :tags do |t|
      t.index :breed_id
      t.index :tag_id
    end
  end
end
