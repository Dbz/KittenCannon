class Tag < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name, case_sensitive: false
  
  before_save { |tag| tag.name = tag.name.downcase }

  has_and_belongs_to_many :breeds
end
