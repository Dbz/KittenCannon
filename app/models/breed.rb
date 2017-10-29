class Breed < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name, case_sensitive: false

  before_save { |breed| breed.name = breed.name.downcase }
  around_destroy :delete_unique_tags

  has_and_belongs_to_many :tags

  private

  def delete_unique_tags
    # 3 Queries:
    # 1. Grab associated tags
    # 2. Subtract associated tags that have additional breeds_tags joins
    # 3. Delete remaining tags
    
    current_tags = Tag.joins(:breeds).where("breeds_tags.breed_id = #{id}").pluck(:id)
    tags_with_additional_joins = Tag.where(id: current_tags).joins(:breeds).where.not("breeds_tags.breed_id = #{id}").pluck(:id)
    yield
    Tag.where(id: current_tags - tags_with_additional_joins).destroy_all
  end
end
