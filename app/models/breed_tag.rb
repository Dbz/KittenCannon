class BreedTag < ApplicationRecord
  belongs_to :breed
  belongs_to :tag

  validates :breed_id, uniqueness: { scope: :tag_id }
end
