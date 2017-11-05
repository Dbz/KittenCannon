require 'rails_helper'

describe Resolvers::UpdateTag do
  describe 'updating a Tag' do
    let!(:breed) { Resolvers::CreateBreed.new.call(nil, { name: 'b' }, {}) }
    let!(:tag) { Resolvers::CreateTag.new.call(nil, { name: 't', breed_id: breed.id }, {}) }

    it 'updates a tag from the database' do
      expect(tag.name).to eq 't'
      Resolvers::UpdateTag.new.call(nil, { name: 't2', id: tag.id }, {})
      expect(Tag.find(tag.id).name).to eq 't2'
    end

    it 'throws an error when the record can not be found' do
      expect do
        Resolvers::UpdateTag.new.call(nil, { name: 't', id: 100 }, {})
      end.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
