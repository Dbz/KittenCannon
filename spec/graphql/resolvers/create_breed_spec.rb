require 'rails_helper'

types = GraphQL::Define::TypeDefiner.instance

describe Resolvers::CreateBreed do
  describe 'creating a new Breed' do
    let!(:breed) { Resolvers::CreateBreed.new.call(nil,{ name: 'b' }, {}) }
    
    it 'persists to the database' do
      expect(breed.persisted?).to be true
    end
  end
end
