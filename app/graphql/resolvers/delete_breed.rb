class Resolvers::DeleteBreed < GraphQL::Function
  argument :id, !types.ID

  type Types::BreedType

  def call(_obj, args, _ctx)
    Breed.destroy(args[:id])
  end
end
