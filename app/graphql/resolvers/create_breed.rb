class Resolvers::CreateBreed < GraphQL::Function
  argument :name, !types.String

  type Types::BreedType

  def call(_obj, args, _ctx)
    Breed.create!(name: args[:name])
  end
end
