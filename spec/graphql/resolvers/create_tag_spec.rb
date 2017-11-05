require 'rails_helper'

types = GraphQL::Define::TypeDefiner.instance

describe Resolvers::CreateTag do
  describe 'creating a new Tag' do
    let!(:breed) { Resolvers::CreateBreed.new.call(nil,{ name: 'b' }, {}) }
    let!(:tag) { Resolvers::CreateTag.new.call(nil,{ name: 't', breed_id: breed.id }, {}) }
    
    it 'persists to the database' do
      expect(tag.persisted?).to be true
    end

    it 'throws an error when the record already exists' do
      expect { Resolvers::CreateTag.new.call(nil,{ name: 't', breed_id: breed.id }, {}) }.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
