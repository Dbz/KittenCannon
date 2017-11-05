# frozen_string_literal: true
Types::TagType = GraphQL::ObjectType.define do
  name 'Tag'
  field :id, !types.ID
  field :name, !types.String
  field :breed_count, types.Int

  field :breeds, -> { !types[!Types::BreedType] }
end
