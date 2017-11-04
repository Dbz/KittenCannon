class Resolvers::UpdateTag < GraphQL::Function
  argument :name, !types.String
  argument :id, !types.ID

  type Types::TagType

  def call(_obj, args, _ctx)
    Tag.update(args[:id], name: args[:name])
  end
end
