class CreateBreedTags < ActiveRecord::Migration[5.1]
  def change
    create_table :breed_tags do |t|
      t.belongs_to :breed, foreign_key: true
      t.belongs_to :tag, foreign_key: true
      t.timestamps

      t.index [:breed_id, :tag_id], unique: true
    end
  end
end
