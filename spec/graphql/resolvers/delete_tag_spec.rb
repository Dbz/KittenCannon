require 'rails_helper'

types = GraphQL::Define::TypeDefiner.instance

describe Resolvers::DeleteTag do
  describe 'deleting a Tag' do
    let!(:breed) { Resolvers::CreateBreed.new.call(nil,{ name: 'b' }, {}) }
    let!(:tag) { Resolvers::CreateTag.new.call(nil,{ name: 't', breed_id: breed.id }, {}) }
    
    it 'deletes a tag from the database' do
      expect(tag.persisted?).to be true
      Resolvers::DeleteTag.new.call(nil, { id: tag.id }, {})
      expect(Tag.where(id: tag.id)).to be_empty
    end
  end
end
