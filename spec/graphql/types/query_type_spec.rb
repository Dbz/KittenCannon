require 'rails_helper'

describe Types::QueryType do
  describe 'fields' do
    it { is_expected.to have_field(:allBreeds).of_type('[Breed]!') }
    it { is_expected.to have_field(:allTags).of_type('[Tag]!') }
  end
end
