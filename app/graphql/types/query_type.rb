Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :allBreeds, !types[Types::BreedType] do
    description "Fetch all of the Breeds"
    resolve ->(obj, args, ctx) { Breed.all }
  end

  field :allTags, !types[Types::TagType] do
    description "Fetch all of the Tags"
    resolve ->(obj, args, ctx) { Tag.all }
  end
end
