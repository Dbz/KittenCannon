Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :createBreed, function: Resolvers::CreateBreed.new
  field :createTag, function: Resolvers::CreateTag.new

  field :updateBreed, function: Resolvers::UpdateBreed.new
  field :updateTag, function: Resolvers::UpdateTag.new

  field :deleteBreed, function: Resolvers::DeleteBreed.new
  field :deleteTag, function: Resolvers::DeleteTag.new
end
