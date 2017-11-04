class Resolvers::CreateTag < GraphQL::Function
  argument :name, !types.String
  argument :breed_id, !types.ID

  type Types::TagType

  def call(_obj, args, _ctx)
    breed = Breed.find(args[:breed_id])

    tag = Tag.find_or_create_by(name: args[:name].downcase).tap do |tag|
      breed.tags << tag 
      breed.save!
    end
  end
end
