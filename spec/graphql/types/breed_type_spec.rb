require 'rails_helper'

types = GraphQL::Define::TypeDefiner.instance

describe Types::BreedType do
  describe 'fields' do
    it { is_expected.to have_field(:id).that_returns(!types.ID) }
    it { is_expected.to have_field(:name).that_returns(!types.String) }
    it { is_expected.to have_field(:tags).of_type('[Tag]') }
  end
end
