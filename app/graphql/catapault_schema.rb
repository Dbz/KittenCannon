CatapaultSchema = GraphQL::Schema.define do
  mutation(Types::MutationType)
  query(Types::QueryType)
end

GraphQL::Errors.configure(CatapaultSchema) do
  rescue_from ActiveRecord::RecordNotFound do |exception|
    GraphQL::ExecutionError.new("Record not found: #{exception.message}")
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    GraphQL::ExecutionError.new(exception.record.errors.full_messages.join("\n"))
  end

  rescue_from StandardError do |exception|
    GraphQL::ExecutionError.new("Exception Caught: #{exception.message}")
  end
end
