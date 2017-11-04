require 'rails_helper'

types = GraphQL::Define::TypeDefiner.instance

describe Types::TagType do
  describe 'fields' do
    it { is_expected.to have_field(:id).that_returns(!types.ID) }
    it { is_expected.to have_field(:name).that_returns(!types.String) }
    it { is_expected.to have_field(:breed_count).that_returns(types.Int) }
    it { is_expected.to have_field(:breeds).of_type('[Breed!]!') }
  end
end
