require 'rails_helper'

RSpec.describe Tag, type: :model do
  let!(:tag) { Tag.create(name: 'Shoulda-Matchers') }

  describe 'Tag Validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'Tag Associations' do
    it { should have_and_belong_to_many :breeds }
  end

  describe 'Tag Callbacks' do
    it '#save downcases the name when creating and saving' do
      tag = Tag.create(name: 'TAG')
      expect(tag.name).to eq 'tag'

      tag.update_attributes(name: 'TAG')
      expect(tag.name).to eq 'tag'
    end
  end
end
