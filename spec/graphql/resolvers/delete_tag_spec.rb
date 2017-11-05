require 'rails_helper'

describe Resolvers::DeleteTag do
  describe 'deleting a Tag' do
    let!(:breed) { Resolvers::CreateBreed.new.call(nil, { name: 'b' }, {}) }
    let!(:tag) { Resolvers::CreateTag.new.call(nil, { name: 't', breed_id: breed.id }, {}) }

    it 'deletes a tag from the database' do
      expect(tag.persisted?).to be true
      Resolvers::DeleteTag.new.call(nil, { id: tag.id }, {})
      expect(Tag.where(id: tag.id)).to be_empty
    end

    it 'throws an error when the record can not be found' do
      Resolvers::DeleteTag.new.call(nil, { id: tag.id }, {})
      expect { Resolvers::DeleteTag.new.call(nil, { id: tag.id }, {}) }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
