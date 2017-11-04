class Tag < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  before_save { |tag| tag.name = tag.name.downcase }

  has_many :breed_tags, dependent: :destroy
  has_many :breeds, through: :breed_tags

  def breed_count
    breeds.count
  end
end
