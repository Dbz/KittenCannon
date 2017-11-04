require 'rails_helper'

types = GraphQL::Define::TypeDefiner.instance

describe Resolvers::UpdateBreed do
  describe 'updating a Breed' do
    let!(:breed) { Resolvers::CreateBreed.new.call(nil,{ name: 'b' }, {}) }
    let!(:tag) { Resolvers::CreateTag.new.call(nil,{ name: 't', breed_id: breed.id }, {}) }
    
    it 'updates a breed from the database' do
      expect(breed.name).to eq 'b'
      Resolvers::UpdateBreed.new.call(nil, { name: 'b2', id: breed.id }, {})
      expect(Breed.find(breed.id).name).to eq 'b2'
    end
  end
end
