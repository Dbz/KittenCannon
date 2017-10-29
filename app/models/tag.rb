class Tag < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  before_save { |tag| tag.name = tag.name.downcase }

  has_and_belongs_to_many :breeds
end
