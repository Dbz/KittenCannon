require 'rails_helper'

types = GraphQL::Define::TypeDefiner.instance

describe Resolvers::CreateTag do
  describe 'creating a new Tag' do
    let!(:breed) { Resolvers::CreateBreed.new.call(nil,{ name: 'b' }, {}) }
    let!(:tag) { Resolvers::CreateTag.new.call(nil,{ name: 't', breed_id: breed.id }, {}) }
    
    it 'persists to the database' do
      expect(tag.persisted?).to be true
    end
  end
end
