require 'rails_helper'

types = GraphQL::Define::TypeDefiner.instance

describe Types::MutationType do
  describe 'fields' do
    it { is_expected.to have_field(:createBreed).of_type('Breed') }
    it { is_expected.to have_field(:updateBreed).of_type('Breed') }
    it { is_expected.to have_field(:deleteBreed).of_type('Breed') }

    it { is_expected.to have_field(:createTag).of_type('Tag') }
    it { is_expected.to have_field(:updateTag).of_type('Tag') }
    it { is_expected.to have_field(:deleteTag).of_type('Tag') }
  end
end
