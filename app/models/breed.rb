class Breed < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  before_save { |breed| breed.name = breed.name.downcase }
  before_destroy :delete_unique_tags

  has_many :breed_tags, dependent: :destroy
  has_many :tags, through: :breed_tags

  def tag_count
    tags.count
  end

  private

  def delete_unique_tags
    tags.joins(:breed_tags).group('tags.id').having('COUNT(breed_tags.tag_id) = 1').destroy_all
  end
end
