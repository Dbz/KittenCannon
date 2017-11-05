Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  field :allBreeds, !types[Types::BreedType] do
    description 'Fetch all of the Breeds'
    resolve ->(_obj, _args, _ctx) { Breed.all }
  end

  field :allTags, !types[Types::TagType] do
    description 'Fetch all of the Tags'
    resolve ->(_obj, _args, _ctx) { Tag.all }
  end
end
