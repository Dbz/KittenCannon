class Resolvers::DeleteTag < GraphQL::Function
  argument :id, !types.ID

  type Types::TagType

  def call(_obj, args, _ctx)
    Tag.destroy(args[:id])
  end
end
