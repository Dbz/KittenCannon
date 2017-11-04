require 'rails_helper'

RSpec.describe BreedTag, type: :model do
  let!(:breed) { Breed.create(name: 'b') }
  let!(:tag) { Tag.create(name: 't') }
  before { breed.tags << tag }

  describe 'BreedTag Validations' do
    it { should validate_uniqueness_of(:breed_id).scoped_to(:tag_id) }
  end

  describe 'BreedTag Associations' do
    it { should belong_to :breed }
    it { should belong_to :tag }
  end
end
