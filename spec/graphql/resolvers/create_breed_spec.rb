require 'rails_helper'

types = GraphQL::Define::TypeDefiner.instance

describe Resolvers::CreateBreed do
  describe 'creating a new Breed' do
    let!(:breed) { Resolvers::CreateBreed.new.call(nil,{ name: 'b' }, {}) }
    
    it 'persists to the database' do
      expect(breed.persisted?).to be true
    end

    it 'throws an error when the record already exists' do
      expect { Resolvers::CreateBreed.new.call(nil,{ name: 'b' }, {}) }.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
