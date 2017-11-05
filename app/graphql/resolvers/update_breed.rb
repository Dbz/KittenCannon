class Resolvers::UpdateBreed < GraphQL::Function
  argument :name, !types.String
  argument :id, !types.ID

  type Types::BreedType

  def call(_obj, args, _ctx)
    Breed.update(args[:id], name: args[:name])
  end
end
