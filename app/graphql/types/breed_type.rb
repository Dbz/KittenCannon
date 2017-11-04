Types::BreedType = GraphQL::ObjectType.define do
  name "Breed"
  field :id, !types.ID
  field :name, !types.String

  field :tags, -> { types[Types::TagType] }
end
