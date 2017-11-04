require 'rails_helper'

RSpec.describe Tag, type: :model do
  let!(:tag) { Tag.create(name: 'Shoulda-Matchers') }

  describe 'Tag Validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'Tag Associations' do
    it { should have_many(:breed_tags).dependent(:destroy) }
    it { should have_many(:breeds).through(:breed_tags) }
  end

  describe 'Tag Callbacks' do
    it '#save downcases the name when creating and saving' do
      tag = Tag.create(name: 'TAG')
      expect(tag.name).to eq 'tag'

      tag.update_attributes(name: 'TAG')
      expect(tag.name).to eq 'tag'
    end
  end

  describe 'Methods' do
    let(:tag) { Tag.create(name: 'soft') }
    let(:breed1) { Breed.create(name: 'Turkish Van') }
    let(:breed2) { Breed.create(name: 'Tabby') }
    describe '#tag_count' do
      it 'returns the amount of tags on a breed' do
        expect(tag.breed_count).to eq 0
        breed1.tags << tag
        breed2.tags << tag
        expect(tag.breed_count).to eq 2
        breed1.destroy
        expect(tag.breed_count).to eq 1
      end
    end
  end
end
