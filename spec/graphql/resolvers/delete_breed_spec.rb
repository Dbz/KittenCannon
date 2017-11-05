require 'rails_helper'

types = GraphQL::Define::TypeDefiner.instance

describe Resolvers::DeleteBreed do
  describe 'deleting a Breed' do
    let!(:breed) { Resolvers::CreateBreed.new.call(nil,{ name: 'b' }, {}) }
    
    it 'deletes a breed from the database' do
      expect(breed.persisted?).to be true
      Resolvers::DeleteBreed.new.call(nil, { id: breed.id }, {})
      expect(Breed.where(id: breed.id)).to be_empty
    end

    it 'throws an error when the record can not be found' do
      Resolvers::DeleteBreed.new.call(nil, { id: breed.id }, {})
      expect { Resolvers::DeleteBreed.new.call(nil, { id: breed.id }, {}) }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
