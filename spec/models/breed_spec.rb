require 'rails_helper'

RSpec.describe Breed, type: :model do
  let!(:breed) { Breed.create(name: 'Shoulda-Matchers') }

  describe 'Breed Validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'Breed Associations' do
    it { should have_many(:breed_tags).dependent(:destroy) }
    it { should have_many(:tags).through(:breed_tags) }
  end

  describe 'Breed Callbacks' do
    let(:tag1) { Tag.create(name: 'unique') }
    let(:tag2) { Tag.create(name: 'not unique') }
    let(:breed1) { Breed.create(name: 'Turkish Van') }
    let(:breed2) { Breed.create(name: 'Tabby') }

    before do
      breed1.tags = [tag1, tag2]
      breed2.tags = [tag2]
    end

    # Note: Consider spec for destroy failing
    it '#destroy destroys all tags unique to this breed' do
      expect(breed1.tags).to contain_exactly(tag1, tag2)
      expect(breed2.tags).to contain_exactly(tag2)
      expect(Tag.all).to contain_exactly(tag1, tag2)

      breed1.destroy

      expect(Tag.all).to contain_exactly(tag2)
      expect(breed2.tags).to contain_exactly(tag2)
    end

    it '#save downcases the name when creating and saving' do
      breed1 = Breed.create(name: 'CAT')
      expect(breed1.name).to eq 'cat'

      breed1.update_attributes(name: 'KITTY')
      expect(breed1.name).to eq 'kitty'
    end
  end

  describe 'Methods' do
    let(:tag1) { Tag.create(name: 'unique') }
    let(:tag2) { Tag.create(name: 'not unique') }
    let(:breed) { Breed.create(name: 'Turkish Van') }
    describe '#tag_count' do
      it 'returns the amount of tags on a breed' do
        expect(breed.tag_count).to eq 0
        breed.tags << tag1 << tag2
        expect(breed.tag_count).to eq 2
        tag1.destroy
        expect(breed.tag_count).to eq 1
      end
    end
  end
end
