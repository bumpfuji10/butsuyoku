module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :item, Types::ItemType, null:false do
      argument :id, ID, required: true
    end
    def item(id:)
      Item.find(id)
    end

  end
end
